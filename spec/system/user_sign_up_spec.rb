require 'rails_helper'

describe 'Usuário cria conta' do
    it 'com sucesso' do
        #arrange
    
        #act
        visit root_path
        within ('nav') do
            click_on 'Entrar'
        end
        click_on 'Criar conta'
        fill_in 'Nome', with: 'André'
        fill_in 'Sobrenome', with: 'Pereira'
        fill_in 'E-mail', with: 'andre@pousadaria.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        within('form') do
            click_on 'Criar conta'
        end
        
        expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
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
        click_on 'Criar conta'
        fill_in 'Nome', with: 'André'
        fill_in 'Sobrenome', with: 'Pereira'
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        within('form') do
            click_on 'Criar conta'
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
        click_on 'Criar conta'
        fill_in 'Nome', with: ''
        fill_in 'Sobrenome', with: 'Pereira'
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        within('form') do
            click_on 'Criar conta'
        end
        
        expect(page).to have_content 'E-mail não pode ficar em branco'
        expect(page).to have_link 'Entrar'
        expect(page).not_to have_button 'Sair'
    
    end

end