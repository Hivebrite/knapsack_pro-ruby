module KnapsackPro
  module Runners
    class TestUnitRunner < BaseRunner
      def self.run(args)
        ENV['KNAPSACK_PRO_TEST_SUITE_TOKEN'] = KnapsackPro::Config::Env.test_suite_token_test_unit
        ENV['KNAPSACK_PRO_RECORDING_ENABLED'] = 'true'

        runner = new(KnapsackPro::Adapters::TestUnitAdapter)

        if runner.test_files_to_execute_exist?
          require 'test/unit'

          cli_args =
            (args || '').split +
            runner.test_file_paths.map do |f|
              File.expand_path(f)
            end

          exit Test::Unit::AutoRunner.run(
            true,
            runner.test_dir,
            cli_args
          )
        end
      end
    end
  end
end
