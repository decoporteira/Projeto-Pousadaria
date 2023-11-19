require 'rails_helper'

describe 'Owner confirma o check in do hóspede ' do
    it 'com sucesso' do
        #Arrange
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        reservation = Reservation.create!(guest_number: 1, start_date:  25.day.from_now, final_date:  27.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 300)
        
        #act
        login_as(owner_one, scope: :owner)
        visit(room_reservation_path(reservation.room, reservation))
        click_on 'Check in'
    
        #assert
        expect(page).to have_content('Detalhes da estadia')
        expect(page).to have_content('Código da reserva: 12345678')
        expect(page).to have_content('Nome do quarto: Quarto Zelda') 
        expect(page).to have_content('Número de hóspedes: 1')
        expect(page).to have_content("Check in: #{I18n.l(25.day.from_now.to_date)}") 
        expect(page).to have_content("Check out: #{I18n.l(27.day.from_now.to_date)}") 
            
         
    end
end