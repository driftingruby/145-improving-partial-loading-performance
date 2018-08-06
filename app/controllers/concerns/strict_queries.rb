module StrictQueries
  class SQLWithViewError < StandardError; end
  module Concern
    extend ActiveSupport::Concern

    included do
      def render(*args, &block)
        return super if production?

        callback = lambda do |name, start, finish, id, payload|
          if !should_ignore_sql_statement?(payload[:name])
            raise SQLWithViewError.new(message(payload[:sql]))
          end
        end

        ActiveSupport::Notifications.subscribed(callback, 'sql.active_record') do
          super
        end
      end

      private

      def production?
        Rails.env.production?
      end

      def should_ignore_sql_statement?(name)
        ['SCHEMA', 'ActionRecord::SchemaMigration Load'].include?(name)
      end

      def message(sql)
        "A SQL request was issued within the view:\n#{sql}"
      end
    end
  end
end