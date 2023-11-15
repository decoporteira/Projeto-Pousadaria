require 'rails_helper'

describe 'Usuário visita tela inicial de Quartos' do
    it 'a partir do menu na index' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                    neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                        check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
                    
        visit(root_path)
        login(user)
        click_on 'Quartos'
        click_on 'Detalhes'
   
        expect(page).to have_content('Nome: Quarto Pokémon')
        expect(page).to have_content('Descrição: Quarto idéntico ao quarto de Ash.')
        expect(page).to have_content('Tamanho: 20')
        expect(page).to have_content('Hóspedes: 2')
        expect(page).to have_content('Diária: R$ 20,00')
        expect(page).to have_content('Varanda: possui')
        expect(page).to have_content('Ar condicionado: não possui ar condicionado')
        expect(page).to have_content('Tv: não possui tv')
        expect(page).to have_content('Guarda-roupas: possui guarda-roupas ')
        expect(page).to have_content('Cofre: possui cofre')
        expect(page).to have_content('Acessibilidade: quarto sem acessibilidade')
        expect(page).to have_content('Disponibilidade: sim')
       
        
    end
end