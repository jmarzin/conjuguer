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
      expect(page).to have_content %q{PRESENT IMPARFAIT PARFAIT FUTUR INDICATIF Io ho (20)
        Io avevo (20) Io ebbi (20) Io avrò (20) Tu hai (20) Tu avevi (20) Tu avesti (20)
        Tu avrai (20) Lui/lei ha (20) Lui/lei aveva (20) Lui/lei ebbe (20) Lui/lei avrà (20)
        Noi abbiamo (20) Noi avevamo (20) Noi avemmo (20) Noi avremo (20) Voi avete (20)
        Voi avevate (20) Voi aveste (20) Voi avrete (20) Loro hanno (20) Loro avevano (20)
        Loro ebbero (20) Loro avranno (20) PRESENT IMPARFAIT IMPERATIF CONDITIONNEL
        SUBJONCTIF Che io abbia (20) Che io avessi (20) --- (20) Io avrei (20) Che tu abbia (20)
        Che tu avessi (20) Abbi (20) Tu avresti (20) Che lui/lei abbia (20)
        Che lui/lei avesse (20) Abbia (20) Lui/lei avrebbe (20) Che noi abbiamo (20)
        Che noi avessimo (20) Abbiamo (20) Noi avremmo (20) Che voi abbiate (20)
        Che voi aveste (20) Abbiate (20) Voi avreste (20) Che loro abbiano (20)
        Che loro avessero (20) Abbiano (20) Loro avrebbero (20) GERONDIF PARTICIPE PASSE
        Avendo (20) Avuto (20)}
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
      visit '/conjugaisons/1/edit'
      click_button 'Enregistrer'
      visit '/conjugaisons/1'
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
    it "affiche le total des compteurs" do
      visit 'conjugaisons'
      click_link 'Nouvelle Conjugaison'
      expect(page).to have_field("conjugaison[essais_verbe]",\
        with: "#{Conjugaison::Max_essais * Verbe::Formes.size}")
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
      visit '/question'
      click_button 'Vérifier'
      visit '/conjugaisons/1'
      expect(page).to have_content('1001')
      expect(page).to have_content('21')
    end
    it "une bonne réponse décrémente le compteur" do
      visit '/question'
      fill_in 'reponse', :with => find_by_id('attendu').value
      click_button 'Vérifier'
      visit '/conjugaisons/1'
      expect(page).to have_content('999')
      expect(page).to have_content('19')
    end
  end
end