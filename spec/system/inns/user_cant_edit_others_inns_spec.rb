require 'rails_helper'
describe 'Usuário visita tenta visitar tela de quarto que não é dele' do
    it 'e é redirecionado para a home' do
        user_one = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                            neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                            check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user_one.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', 
                            available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id) 
        user_two = User.create!(name: 'Senhor', last_name: 'Furtado', email: 'carlos@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada deo Ladrão', company_name: 'Pousada do Ladrão LTDA', registration_number: '31123213213', phone: '23243434332', email: 'pousada@doladrao.com', address: 'Vila do Chaves, 123', 
                            neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                            check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user_two.id)
        Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', 
        available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_two.id)  
                  
        visit(root_path)
        login(user_one)
        visit(edit_inn_path(inn_two.id))
         
        expect(page).to have_content('Pousadaria')
        expect(current_path).to eq root_path
        
       
    end
    
end