require 'spec_helper'

describe "Micropost" do

  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in(user) }

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect do
          puts html
          click_link "delete" 
        end.to change(Micropost, :count).by(-1)
      end
    end
  end
end
