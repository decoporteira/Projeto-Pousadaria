require 'rails_helper'

describe 'Usuário e Guest veem nota do Inn' do

    it 'a partir do menu' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada da Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        reservation = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :ended)
        reservation = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :ended)
        review = Review.create!(rating: 2, comment: 'Uma estadia média', reservation_id: reservation.id, reply: 'Você também foi um hóspede médio.') 
        review = Review.create!(rating: 4, comment: 'Uma estadia média', reservation_id: reservation.id, reply: 'Você também foi um hóspede médio.') 
        
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Pousada da Nintendo'
        
        #assert
    
        expect(page).to have_content('Nota: 3')
    
        
    end

    it 'quando a pousada ainda não tem avaliações' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada da Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        reservation = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :ended)
        reservation = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :ended)
        
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Pousada da Nintendo'
        
        #assert
    
        expect(page).to have_content('Sem avaliações')
    
        
    end
end