# frozen_string_literal: true

module RuboCop
  module Cop
    module Spbtv
      module Postgres
        # Do not use find_each with Postgresql.
        #
        # ActiveRecord's find_each and find_in_batches ignore non-integer primary keys,
        # so correct execution is not guaranteed in case of joining tables.
        # Workaround: use https://github.com/afair/postgresql_cursor gem with its each_instance method.
        #
        # @example
        #   @bad
        #   Model.find_each { |instance| instance.do_something }
        #   @good
        #   Model.each_instance { |instance| instance.do_something }
        #
        class FindEach < Cop
          MSG = 'Do not use find_each or find_in_batches, as the keys are non-integer.'.freeze

          def on_send(node)
            _, method, * = *node
            add_offense(node, location: :expression, message: MSG) if %i[find_each find_in_batches].include?(method)
          end
        end
      end
    end
  end
end
