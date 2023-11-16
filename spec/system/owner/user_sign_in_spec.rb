require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com sucesso' do
        #arrange
        Owner.create!(name: 'André', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        #act
        visit root_path
        click_on 'Anfitrião'
        fill_in 'E-mail', with: 'andre@pousadaria.com'
        fill_in 'Senha', with: 'password'
        within('.new_user') do
            click_on 'Entrar'
        end
        #assert
        expect(current_path).to eq new_inn_path
        expect(page).to have_content 'Você não tem uma pousada cadastrada. Por favor, complete seu cadastro.'
        expect(page).not_to have_link 'Entrar'
        expect(page).to have_button 'Sair'
        within ('nav') do
            expect(page).to have_content 'andre@pousadaria.com'
        end
    end
    it 'e faz logout' do
        Owner.create!(name: 'André', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
    
        visit root_path
        click_on 'Anfitrião'
        fill_in 'E-mail', with: 'andre@pousadaria.com'
        fill_in 'Senha', with: 'password'
        within('.new_user') do
            click_on 'Entrar'
        end

        within ('nav') do
            expect(page).not_to have_link 'Entrar'
            expect(page).to have_button 'Sair'
        end
        within ('nav') do
            expect(page).to have_content 'andre@pousadaria.com'
        end
    end

end