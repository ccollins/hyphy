require 'spec_helper'

describe Swaggie::Dataset do

  let!(:sql_statement1) { Swaggie::SQLStatement.create(:statement => "select * from table1",
                                                       :start_time => 1.001,
                                                       :end_time => 2.002) }

  let!(:sql_statement2) { Swaggie::SQLStatement.create(:statement => "select * from table2",
                                                       :start_time => 1.001,
                                                       :end_time => 2.002) }

  let(:dataset) { Swaggie::Dataset.new }

  describe "#get_data" do

    it "stores all sql statements in the data attribute" do
      dataset.get_data
      dataset.data.should == [sql_statement1, sql_statement2]
    end

  end

  describe "#apply_filter" do

    it "filters the in memory dataset" do
      Swaggie::AbstractFilter.any_instance.stub(:filter)
        .and_return([sql_statement1])

      dataset.get_data
      dataset.apply_filter(Swaggie::AbstractFilter)
      dataset.data.should == [sql_statement1]
    end

  end

end