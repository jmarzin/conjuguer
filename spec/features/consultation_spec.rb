require 'spec_helper'

describe 'Verbes' do
  before(:each) do
    Conjugaison.create(infinitif: 'avere',essais: 20, detail: IO.binread('db/avere.bin'))
    @avere = Marshal.load(Conjugaison.first.detail)
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
    it "le détail codé n'est pas accessible" do
      visit 'conjugaisons'
      click_link 'Edit'
      expect(page).to_not have_content 'Detail'
    end
    it "les informations du détail sont visibles" do
      visit 'conjugaisons'
      click_link 'Edit'
      expect(page).to have_content 'Voyelle'
      expect(page).to have_content 'Gérondif Participe passé Participe présent'
    end
    it "les informations ne sont pas changées si on sauve sans modif" do
      visit 'conjugaisons/1'
      t1 = page.text
      click_link 'Edit'
      click_button 'Save'
      expect(page.text).to eq('Conjugaison was successfully updated. '+t1)
    end
  end
end