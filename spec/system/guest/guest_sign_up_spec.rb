require 'rails_helper'

describe 'Hóspede cria conta' do
    it 'com sucesso' do
        #arrange
    
        #act
        visit root_path
        within ('nav') do
            click_on 'Hóspede'
        end
        click_on 'Criar conta'
        fill_in 'Nome', with: 'André'
        fill_in 'Cpf', with: '07345445319'
        fill_in 'E-mail', with: 'andre@guest.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar conta'
        
        
        expect(page).to have_content 'Pousadas Recentes'
        expect(page).not_to have_link 'Seus Dados'
        expect(page).to have_button 'Sair'
        within ('nav') do
            expect(page).to have_content 'André'
        end
        expect(current_path).to eq root_path
    
    end

    it 'com email em branco' do
        #arrange
    
        #act
        visit root_path
        within ('nav') do
            click_on 'Hóspede'
        end
        click_on 'Criar conta'
        fill_in 'Nome', with: 'André'
        fill_in 'Cpf', with: '073.454.343-19'
        fill_in 'E-mail', with: ''
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar conta'
        
        
        expect(page).to have_content 'E-mail não pode ficar em branco'
        expect(page).not_to have_button 'Sair'
        expect(page).to have_link 'Hóspede'
    
    end

    it 'com nome em branco' do
        #arrange
    
        #act
        visit root_path
        within ('nav') do
            click_on 'Hóspede'
        end
        click_on 'Criar conta'
        fill_in 'Nome', with: ''
        fill_in 'Cpf', with: '073.454.343-19'
        fill_in 'E-mail', with: 'guest@guest.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar conta'
        
        expect(page).to have_content 'Nome não pode ficar em branco'
        expect(page).to have_link 'Hóspede'

    end

    it 'com nome e cpf em branco' do
        #arrange
    
        #act
        visit root_path
        within ('nav') do
            click_on 'Hóspede'
        end
        click_on 'Criar conta'
        fill_in 'Nome', with: ''
        fill_in 'Cpf', with: '073.454.343-19'
        fill_in 'E-mail', with: 'guest@guest.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar conta'
        
        expect(page).to have_content 'Nome não pode ficar em branco'
        expect(page).not_to have_content 'Cpf não pode ficar em branco'
        expect(page).to have_link 'Hóspede'
        expect(page).not_to have_button 'Sair'

    end

    it 'com CPF em branco' do
        #arrange
    
        #act
        visit root_path
        within ('nav') do
            click_on 'Hóspede'
        end
        click_on 'Criar conta'
        fill_in 'Nome', with: 'Deco'
        fill_in 'Cpf', with: ''
        fill_in 'E-mail', with: 'guest@guest.com'
        fill_in 'Senha', with: 'password'
        fill_in 'Confirme sua senha', with: 'password'
        click_on 'Criar conta'
        
        expect(page).to have_content 'Cpf não pode ficar em branco'
        expect(page).to have_link 'Hóspede'
        expect(page).not_to have_button 'Sair'
    

    end

end
