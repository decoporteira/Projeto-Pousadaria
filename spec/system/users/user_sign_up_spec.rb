require 'rails_helper'

describe 'Usuário cria conta' do
    it 'com sucesso' do
        #arrange
    
        #act
        visit root_path
        within ('nav') do
            click_on 'Entrar'
        end
        click_on 'Sign up'
        fill_in 'Nome', with: 'André'
        fill_in 'Sobrenome', with: 'Pereira'
        fill_in 'E-mail', with: 'andre@pousadaria.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        within('.new_user') do
            click_on 'Sign up'
        end
        
        expect(current_path).to eq new_inn_path
        expect(page).to have_content 'Você não tem uma pousada cadastrada. Por favor, complete seu cadastro.'
        expect(page).not_to have_link 'Entrar'
        expect(page).to have_button 'Sair'
        within ('nav') do
            expect(page).to have_content 'André'
            expect(page).to have_content 'andre@pousadaria.com'
        end
    
    end
    it 'com email em branco' do
        #arrange
    
        #act
        visit root_path
        within ('nav') do
            click_on 'Entrar'
        end
        click_on 'Sign up'
        fill_in 'Nome', with: 'André'
        fill_in 'Sobrenome', with: 'Pereira'
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        within('.new_user') do
            click_on 'Sign up'
        end
        
        expect(page).to have_content 'E-mail não pode ficar em branco'
        expect(page).to have_link 'Entrar'
        expect(page).not_to have_button 'Sair'
    
    end
    it 'com nome em branco' do
        #arrange
    
        #act
        visit root_path
        within ('nav') do
            click_on 'Entrar'
        end
        click_on 'Sign up'
        fill_in 'Nome', with: ''
        fill_in 'Sobrenome', with: 'Pereira'
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        within('.new_user') do
            click_on 'Sign up'
        end
        
        expect(page).to have_content 'E-mail não pode ficar em branco'
        expect(page).to have_link 'Entrar'
        expect(page).not_to have_button 'Sair'
    
    end

end