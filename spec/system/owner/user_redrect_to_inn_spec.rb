require 'rails_helper'

describe 'Usuário criar conta' do
    it 'é é redirecionado para cadastro de pousada' do
        #arrange
    
        #act
        visit root_path
        within ('nav') do
            click_on 'Anfitrião'
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
       
    end

    it 'e ainda não cadastrou uma pousada' do
        #arrange
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role:1)

        #act
        visit root_path
        login(user)
        
        expect(current_path).to eq new_inn_path
        expect(page).to have_content 'Você não tem uma pousada cadastrada. Por favor, complete seu cadastro.'
        
    end

    it 'e ainda não cadastrou uma pousada e tenta clicar em outro link' do
        #arrange
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role:1)

        #act
        visit root_path
        login(user)
        click_on 'Seus dados'
        
        expect(current_path).to eq new_inn_path
        expect(page).to have_content 'Você não tem uma pousada cadastrada. Por favor, complete seu cadastro.'
        
    end

end