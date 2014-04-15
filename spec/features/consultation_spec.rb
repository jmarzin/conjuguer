require 'spec_helper'

describe 'consultation des verbes' do
  before(:each) do
    Conjugaison.create(infinitif: 'avere',essais: 20, detail: IO.binread('db/avere.bin'))
    @avere = Verbe.new(Conjugaison.first)
  end
  it 'la liste ne comprend pas le détail' do
    visit 'conjugaisons'
    expect(page).to_not have_content 'Detail'
  end

  it 'un verbe montre un tableau des temps' do
    visit 'conjugaisons'
    click_link 'Show'
    expect(page).to have_content %q{PRESENT IMPARFAIT PARFAIT FUTUR ho avevo ebbi avrò hai
      avevi avesti avrai INDICATIF ha aveva ebbe avrà abbiamo avevamo avemmo avremo
      avete avevate aveste avrete hanno avevano ebbero avranno PRESENT IMPARFAIT
      IMPERATIF CONDITIONNEL SUBJONCTIF INFINITIF GERONDIF PARTICIPE PASSE PARTICIPE PRESENT}
  end
end