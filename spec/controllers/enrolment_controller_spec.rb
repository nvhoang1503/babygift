require 'spec_helper'

describe EnrolmentController do

  describe "GET 'step_1'" do
    it "returns http success" do
      get 'step_1'
      response.should be_success
    end
  end

  describe "GET 'step_2'" do
    it "returns http success" do
      get 'step_2'
      response.should be_success
    end
  end

  describe "GET 'step_3'" do
    it "returns http success" do
      get 'step_3'
      response.should be_success
    end
  end

  describe "GET 'step_4'" do
    it "returns http success" do
      get 'step_4'
      response.should be_success
    end
  end

  describe "GET 'step_5'" do
    it "returns http success" do
      get 'step_5'
      response.should be_success
    end
  end

  describe "GET 'finish'" do
    it "returns http success" do
      get 'finish'
      response.should be_success
    end
  end

end
