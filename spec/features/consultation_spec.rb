require 'spec_helper'

describe 'Verbes' do
  before(:each) do
    FactoryGirl.create(:avere)
    @avere = Marshal.load(Conjugaison.first.detail)
  end
  describe 'Consultation' do
    it 'la liste ne comprend pas le détail' do
      visit 'conjugaisons'
      expect(page).to_not have_content 'Detail'
    end

    it 'un verbe montre un tableau des temps' do
      visit 'conjugaisons'
      click_link 'Voir'
      expect(page).to have_content %q{PRESENT IMPARFAIT PARFAIT FUTUR INDICATIF Io ho Io avevo
        Io ebbi Io avrò Tu hai Tu avevi Tu avesti Tu avrai Lui/Lei ha Lui/Lei aveva Lui/Lei ebbe
        Lui/Lei avrà Noi abbiamo Noi avevamo Noi avemmo Noi avremo Voi avete Voi avevate Voi aveste
        Voi avrete Loro hanno Loro avevano Loro ebbero Loro avranno PRESENT IMPARFAIT
        IMPERATIF CONDITIONNEL SUBJONCTIF Che io abbia Che io avessi --- Io avrei Che tu abbia
        Che tu avessi abbi Tu avresti Che lui/lei abbia Che lui/lei avesse abbia Lui/Lei avrebbe
        Che noi abbiamo Che noi avessimo abbiamo Noi avremmo Che voi abbiate Che voi aveste
        abbiate Voi avreste Che loro abbiano Che loro avessero abbiano Loro avrebbero INFINITIF GERONDIF PARTICIPE PASSE PARTICIPE PRESENT
        avere avendo avuto avente}
    end
  end
  describe 'Modification' do
    it "le détail codé n'est pas accessible" do
      visit 'conjugaisons'
      click_link 'Corriger'
      expect(page).to_not have_content 'Detail'
    end
    it "les informations du détail sont visibles" do
      visit 'conjugaisons'
      click_link 'Corriger'
      expect(page).to have_content 'Voyelle'
      expect(page).to have_content 'Gérondif Participe passé Participe présent'
    end
    it "les informations ne sont pas changées si on sauve sans modif" do
      visit 'conjugaisons/1'
      t1 = page.text
      click_link 'Corriger'
      click_button 'Enregistrer'
      expect(page.text).to eq('La conjugaison a bien été mise à jour. '+t1)
    end
  end
  describe "Création" do
    it "affiche Nouvelle conjugaison" do
      visit 'conjugaisons'
      click_link 'Nouvelle Conjugaison'
      expect(page.text).to have_content 'Nouvelle conjugaison'
    end
  end
  describe "Copie" do
    it "affiche la correction de la copie du verbe" do
      visit 'conjugaisons'
      click_link 'Copier'
      expect(page).to have_field("conjugaison[infinitif]", with: 'Copie de avere')
    end
  end
end