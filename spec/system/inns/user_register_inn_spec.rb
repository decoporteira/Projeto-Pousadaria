require 'rails_helper'

describe 'Usuário cadastra pousada' do
    it 'com sucesso' do
        #arrange
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
       
        #act
        visit root_path
        click_on 'Entrar'
        fill_in 'E-mail', with: 'andre@pousadaria.com'
        fill_in 'Senha', with: 'password'
        within('form') do
            click_on 'Entrar'
        end
        click_on 'Cadastrar pousada'
        fill_in 'Nome fantasia', with: 'Pousada dos Amores'
        #
       
        #assert
        expect(page).to have_content 'Cadastre sua pousada'
        expect(page).not_to have_link 'Entrar'
        expect(page).to have_button 'Sair'
        within ('nav') do
            expect(page).to have_content 'andre@pousadaria.com'
        end
    end
end