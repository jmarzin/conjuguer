require 'spec_helper'

describe 'Verbes' do
  before(:each) do
    Conjugaison.create(infinitif: 'avere',essais: 20, detail: IO.binread('db/avere.bin'))
    @avere = Verbe.new(Conjugaison.first)
  end
  describe 'Consultation' do
    it 'la liste ne comprend pas le détail' do
      visit 'conjugaisons'
      expect(page).to_not have_content 'Detail'
    end

    it 'un verbe montre un tableau des temps' do
      visit 'conjugaisons'
      click_link 'Show'
      expect(page).to have_content %q{PRESENT IMPARFAIT PARFAIT FUTUR INDICATIF ho avevo ebbi avrò hai
        avevi avesti avrai ha aveva ebbe avrà abbiamo avevamo avemmo avremo
        avete avevate aveste avrete hanno avevano ebbero avranno PRESENT IMPARFAIT
        IMPERATIF CONDITIONNEL SUBJONCTIF abbia avessi --- avrei abbia avessi abbi avresti
        abbia avesse abbia avrebbe abbiamo avessimo abbiamo avremmo abbiate aveste abbiate avreste
        abbiano avessero abbiano avrebbero INFINITIF GERONDIF PARTICIPE PASSE PARTICIPE PRESENT
        avere avendo avuto avente}
    end
  end
  describe 'Modification' do
    it "le détail n'est pas accessible" do
      visit 'conjugaisons'
      click_link 'Edit'
      expect(page).to_not have_content 'Detail'
    end
    it "le texte voyelle est visible" do
      visit 'conjugaisons'
      click_link 'Edit'
      expect(page).to have_content 'Voyelle'
    end
  end
end