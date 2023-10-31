require 'rails_helper'

describe 'Usuário cadastra pousada' do
    it 'com sucesso' do
        #arrange
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
       
        #act
        visit root_path
        login(user)
        click_on 'Cadastrar pousada'
        fill_in 'Nome fantasia', with: 'Pousada dos Amores'
        fill_in 'Razão social', with: 'Pousada dos Amores SA'
        fill_in 'CNPJ', with: '5454354355435-093'
        fill_in 'Telefone', with: '2199922-23243'
        fill_in 'E-mail', with: 'pousada@amores.com'
        fill_in 'Endereço', with: 'Rua das Praias, 345'
        fill_in 'Bairro', with: 'Enseada'
        fill_in 'Cidade', with: 'Praia Grande'
        fill_in 'CEP', with: '32456-766'
        fill_in 'Descrição', with: 'A Pousada mais romântica de toda a cidade.'
        fill_in 'Métodos de pagamento', with: 'Pix, dinheiro e cartão de crédito'
        select 'Permitidos', from: 'Animais'
        fill_in 'Regras', with: '- Não aceitamos festas.'
        fill_in 'Entrada', with: '14:00'
        fill_in 'Saída', with: '12:00'
        select 'ativa', from: 'Status'
        click_on 'Salvar'
        
        #
       
        #assert
        expect(page).to have_content 'Pousada cadastrada com sucesso.'
        expect(page).not_to have_link 'Entrar'
        expect(page).to have_button 'Sair'
         inn_count = Inn.all.length
    end
end