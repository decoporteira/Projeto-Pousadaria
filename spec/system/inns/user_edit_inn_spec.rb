require 'rails_helper'

describe 'Usuário visita tela de edição da Pousada' do
    it 'com sucesso' do
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password',  role: 1)
        Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                    neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                        check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user.id)
        
        visit(root_path)
        login(user)
                        
        click_on 'Pousada'
        click_on 'Detalhes'
        click_on 'Editar detalhes'
        
        expect(page).to have_content('Editar dados da Pousada')

    end
    it 'com sucesso e editar os dados' do
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
        neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
            check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user.id)
        visit(root_path)
        login(user)
       

        visit(root_path)
        click_on 'Pousada'
        click_on 'Detalhes'
        click_on 'Editar detalhes'
        fill_in 'Nome fantasia', with: 'Pousada dos Amores'
        click_on 'Salvar'
       
        expect(page).to have_content('Nome Fantasia: Pousada dos Amores')
        expect(page).to have_content('Razão Social: Pousada de Teste LTDA')
    end

end