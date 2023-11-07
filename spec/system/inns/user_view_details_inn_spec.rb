require 'rails_helper'

describe 'Usuário visita tela de detalhes de Pousada' do
    it 'a partir do menu na index' do
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        visit(root_path)
        login(user)
        Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                    neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                        check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user.id)

        visit(root_path)
        click_on 'Pousada'
        click_on 'Detalhes'
        
        expect(page).to have_content('Detalhes da Pousada')
        expect(page).to have_content('Nome Fantasia: Pousada de Teste')
        expect(page).to have_content('Razão Social: Pousada de Teste LTDA')
        expect(page).to have_content('CNPJ: 5454354355435')
        expect(page).to have_content('Telefone: 23243423432')
        expect(page).to have_content('Email: pousada@amores.com')
        expect(page).to have_content('Detalhes da Pousada')
        expect(page).to have_content('Endereço: Rua das Covas, 123')
        expect(page).to have_content('Bairro: Centro')
        expect(page).to have_content('Cidade: Juiz de Fora')
        expect(page).to have_content('CEP: 389434-923')
        expect(page).to have_content('Descrição: A melhor Pousada do mundo.')
        expect(page).to have_content('Formas de pagamento: Apenas PIX')
        expect(page).to have_content('Animais: permitidos')
        expect(page).to have_content('Regras: Não pode ouvir música alta.')
        expect(page).to have_content('Entrada: 12:00')
        expect(page).to have_content('Saída: 14:00')
        expect(page).to have_content('Status: ativa')
    
    end
   
end