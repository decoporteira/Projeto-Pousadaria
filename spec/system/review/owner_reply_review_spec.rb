require 'rails_helper'

describe 'Owner vê as reservas em uma listagem' do
    it 'com sucesso' do
        #Arrange
        guest_one = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        guest_two = Guest.create!(name: 'Lily', cpf: '9899897776', email: 'lily@guest.com', password: 'password')
        owner = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada da Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        reservation_one = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  10.day.from_now, room_id: room_one.id,  guest_id: guest_one.id, total_price: 400, status: :ended)
       
        review_one = Review.create!(rating: 0, comment: 'Estadia péssima, vasos quebrandos, fui atacado por galinhas e uma maldito som de ocarina que não dava sossego!', reservation_id: reservation_one.id)
       
        #act
        login_as(owner, scope: :owner)
        visit(root_path)
        click_on 'Avaliações'
        
       
    
        #assert
        expect(page).to have_content('Avaliações das Estadias:') 
        expect(page).to have_content('Estadia péssima, vasos quebrandos, fui atacado por galinhas e uma maldito som de ocarina que não dava sossego!')

    
        
    end
    
    it 'e responde com sucesso' do
        #Arrange
        guest_one = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        guest_two = Guest.create!(name: 'Lily', cpf: '9899897776', email: 'lily@guest.com', password: 'password')
        owner = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada da Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        reservation_one = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  10.day.from_now, room_id: room_one.id,  guest_id: guest_one.id, total_price: 400, status: :ended)
       
        review_one = Review.create!(rating: 0, comment: 'Estadia péssima, vasos quebrandos, fui atacado por galinhas e uma maldito som de ocarina que não dava sossego!', reservation_id: reservation_one.id)
       
        #act
        login_as(owner, scope: :owner)
        visit(root_path)
        click_on 'Avaliações'
        click_on 'Responder'
        fill_in 'Resposta', with: 'Obrigado pela avaliação.'
        click_on 'Responder'
       
    
        #assert
        expect(page).to have_content('Resposta enviada com sucesso.')
        expect(page).to have_content('Obrigado pela avaliação.') 
        expect(page).to have_content('Estadia péssima, vasos quebrandos, fui atacado por galinhas e uma maldito som de ocarina que não dava sossego!')

    
        
    end


end