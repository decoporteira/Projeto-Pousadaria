require 'rails_helper'

describe 'Owner vê as reservas em uma listagem' do
    it 'com sucesso' do
        #Arrange
        guest_one = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        guest_two = Guest.create!(name: 'Lily', cpf: '9899897776', email: 'lily@guest.com', password: 'password')
        owner = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada da Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        room_two = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto do Ash e Pikachu.', size: 20, guest: 2, daily_rate: 20, balcony: 'não possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'não possui cofre', accessible: 'quarto com acessibilidade', inn_id: inn.id)  

        reservation_one = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  10.day.from_now, room_id: room_one.id,  guest_id: guest_one.id, total_price: 400, status: :ended)
        reservation_two = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  10.day.from_now, room_id: room_one.id,  guest_id: guest_two.id, total_price: 400, status: :ended)
        
        review_one = Review.create!(rating: 0, comment: 'Estadia péssima, vasos quebrandos, fui atacado por galinhas e uma maldito som de ocarina que não dava sossego!', reservation_id: reservation_one.id)
        review_two = Review.create!(rating: 4, comment: 'Ótimo quarto, era com estar em Pallet, ainda completei minha pokedex!', reservation_id: reservation_two.id)
        
        owner_two = Owner.create!(name: 'Juvenal', last_name: 'Antunes', email: 'juvenal@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Ruim', company_name: 'Pousada de Ruim LTDA', registration_number: '545434354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_two.id)
        room_three = Room.create!(name: 'Quarto Sujo', description: 'Descrição: Quarto imundo.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_two.id)  
        reservation_three = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  10.day.from_now, room_id: room_three.id,  guest_id: guest_one.id, total_price: 400, status: :ended)
        review_three = Review.create!(rating: 5, comment: 'Quarto imundo!', reservation_id: reservation_three.id)
        #act
        login_as(owner, scope: :owner)
        visit(root_path)
        click_on 'Avaliações'
    
        #assert
        expect(page).to have_content('Avaliações das Estadias:') 
        expect(page).to have_content('Estadia péssima, vasos quebrandos, fui atacado por galinhas e uma maldito som de ocarina que não dava sossego!')
        expect(page).not_to have_content('Quarto imundo')
    
        
    end
end