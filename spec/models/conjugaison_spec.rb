require 'spec_helper'

describe Conjugaison do
  it "l'infinitif ne peut pas être blanc" do
    expect(FactoryGirl.build(:conjugaison, infinitif: '')).to have(1).errors_on(:infinitif)
  end
  it "le détail est obligatoire" do
    expect(FactoryGirl.build(:conjugaison, detail: '')).to have(1).errors_on(:detail)
  end
  it "l'infinitif est unique" do
    FactoryGirl.create(:avere)
    expect(Conjugaison.new(infinitif: 'avere')).to have(1).errors_on(:infinitif)
  end
end