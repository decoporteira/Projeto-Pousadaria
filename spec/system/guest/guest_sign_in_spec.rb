require 'rails_helper'

describe 'Hóspde se autentica' do
    it 'com sucesso' do
        #arrange
        Guest.create!(name: 'André Pereira', cpf: '045.543.543-01', email: 'andre@guest.com', password: 'password')
        
        #act
        visit(root_path)
        click_on 'Hóspede'
        fill_in 'E-mail', with: 'andre@guest.com'
        fill_in 'Senha', with: 'password'
        click_on 'Entrar'
        
        #assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Login efetuado com sucesso.'
        expect(page).not_to have_link 'Hóspede'
        expect(page).to have_button 'Sair'
        within ('nav') do
            expect(page).to have_content 'Olá André Pereira'
        end
    end

    it 'com sucesso e faz logout' do
        #arrange
        Guest.create!(name: 'André Pereira', cpf: '045.543.543-01', email: 'andre@guest.com', password: 'password')
        visit(root_path)
        click_on 'Hóspede'
        fill_in 'E-mail', with: 'andre@guest.com'
        fill_in 'Senha', with: 'password'
        click_on 'Entrar'
        click_on 'Sair'
        #act
        
        
        #assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Logout efetuado com sucesso.'
        expect(page).to have_link 'Hóspede'
        expect(page).not_to have_button 'Sair'
        within ('nav') do
            expect(page).not_to have_content 'Olá André Pereira'
        end
    end
end