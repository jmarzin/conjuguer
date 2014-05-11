require 'spec_helper'

describe 'Verbes' do
  before(:each) do
    FactoryGirl.create(:avere)
  end
  describe 'Consultation' do
    it 'la liste ne comprend pas le détail' do
      visit 'conjugaisons'
      expect(page).to_not have_content 'Detail'
    end

    it 'un verbe montre un tableau des temps' do
      visit 'conjugaisons'
      click_link 'Voir'
      expect(page).to have_content %q{PRESENT IMPARFAIT PARFAIT FUTUR INDICATIF Io ho (16)
        Io avevo (16) Io ebbi (16) Io avrò (16) Tu hai (16) Tu avevi (16) Tu avesti (16)
        Tu avrai (16) Lui/lei ha (16) Lui/lei aveva (16) Lui/lei ebbe (16) Lui/lei avrà (16)
        Noi abbiamo (16) Noi avevamo (16) Noi avemmo (16) Noi avremo (16) Voi avete (16)
        Voi avevate (16) Voi aveste (16) Voi avrete (16) Loro hanno (16) Loro avevano (16)
        Loro ebbero (16) Loro avranno (16) PRESENT IMPARFAIT IMPERATIF CONDITIONNEL
        SUBJONCTIF Che io abbia (16) Che io avessi (16) --- (16) Io avrei (16) Che tu abbia (16)
        Che tu avessi (16) Abbi (16) Tu avresti (16) Che lui/lei abbia (16)
        Che lui/lei avesse (16) Abbia (16) Lui/lei avrebbe (16) Che noi abbiamo (16)
        Che noi avessimo (16) Abbiamo (16) Noi avremmo (16) Che voi abbiate (16)
        Che voi aveste (16) Abbiate (16) Voi avreste (16) Che loro abbiano (16)
        Che loro avessero (16) Abbiano (16) Loro avrebbero (16) GERONDIF PARTICIPE PASSE
        Avendo (16) Avuto (16)}
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
      expect(page).to have_content 'Gérondif Essais Participe passé'
    end
    it "les informations ne sont pas changées si on sauve sans modif" do
      visit '/conjugaisons'
      click_link 'Corriger'
      click_button 'Enregistrer'
      visit '/conjugaisons/'
      click_link 'Voir'
      /Révision des conjugaisons(.*)/.match(page.text)
      t1 = $1
      click_link 'Corriger'
      click_button 'Enregistrer'
      expect(page.text).to include(t1)
    end
  end
  describe "Création" do
    it "affiche Nouvelle conjugaison" do
      visit 'conjugaisons'
      click_link 'Nouvelle Conjugaison'
      expect(page.text).to have_content 'Nouvelle conjugaison'
    end
    it "affiche le total des compteurs" do
      visit 'conjugaisons'
      click_link 'Nouvelle Conjugaison'
      expect(page).to have_field("conjugaison[essais_verbe]",\
        with: "#{Conjugaison::MAX_ESSAIS * Verbe::FORMES.size}")
    end
  end
  describe "Copie" do
    it "affiche la correction de la copie du verbe" do
      visit 'conjugaisons'
      click_link 'Copier'
      expect(page).to have_field("conjugaison[infinitif]", with: 'Copie de avere')
    end
  end
  describe "Questions" do
    it "une erreur incrémente le compteur" do
      visit '/questions/conjugaison'
      click_button 'Vérifier'
      visit '/conjugaisons'
      click_link 'Voir'
      expect(page).to have_content('848')
      expect(page).to have_content('32')
    end
    it "une bonne réponse décrémente le compteur" do
      visit '/questions/conjugaison'
      fill_in 'reponse', :with => find_by_id('attendu').value
      click_button 'Vérifier'
      visit '/conjugaisons'
      click_link 'Voir'
      expect(page).to have_content('800')
      expect(page).to have_content('8')
    end
  end
end
