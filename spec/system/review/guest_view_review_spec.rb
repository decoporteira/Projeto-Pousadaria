require 'rails_helper'

describe 'Guest ve reservas finalizadas na listagem' do
    it 'a partir do menu' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        owner_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.', check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: owner_two.id)
        room_two = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_two.id)  

        allow(SecureRandom).to receive(:alphanumeric).and_return('98765432')
        Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :ended)
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        Reservation.create!(guest_number: 2, start_date:  Date.today, final_date:  27.day.from_now, room_id: room_two.id,  guest_id: guest.id, total_price: 300, status: :active)
        
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Minhas reservas'
        # click_on 'Quarto Pokémon'
    
        #assert
        expect(page).to have_content('Nome do quarto: Quarto Pokémon') 
        expect(page).to have_content('Código da reserva: 12345678')
        expect(page).to have_content('Preço total da estadia: R$ 300,00') 
       
        expect(page).to have_content('Nome do quarto: Quarto Zelda') 
        expect(page).to have_content('Preço total da estadia: R$ 400,00') 
        expect(page).to have_content('Código da reserva: 98765432')
        
    end

    it 'e vê o botão Avaliar estadia' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        owner_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.', check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: owner_two.id)
        room_two = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_two.id)  

        allow(SecureRandom).to receive(:alphanumeric).and_return('98765432')
        Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :ended)
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        Reservation.create!(guest_number: 2, start_date:  Date.today, final_date:  27.day.from_now, room_id: room_two.id,  guest_id: guest.id, total_price: 300, status: :ended)
        
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Minhas reservas'
        click_on 'Quarto Pokémon'
    
        #assert
        expect(page).to have_content('Nome do quarto: Quarto Pokémon') 
        expect(page).to have_content('Código da reserva: 12345678')
        expect(page).to have_content('Preço total da estadia: R$ 300,00')
        expect(page).to have_content('Avaliar estadia')

        #expect(page).to have_content('Conte-nos como foi sua experiência na Pousada Nerd')  

       
        
    end

    it 'e não vê o botão Avaliar estadia' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        owner_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.', check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: owner_two.id)
        room_two = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_two.id)  

        allow(SecureRandom).to receive(:alphanumeric).and_return('98765432')
        Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :active)
        allow(SecureRandom).to receive(:alphanumeric).and_return('12345678')
        Reservation.create!(guest_number: 2, start_date:  Date.today, final_date:  27.day.from_now, room_id: room_two.id,  guest_id: guest.id, total_price: 300, status: :canceled)
        
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Minhas reservas'
        click_on 'Quarto Zelda'
    
        #assert

        expect(page).not_to have_content('Avaliar estadia')
    end


    it 'e vê o formulário de avaliação' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada da Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        allow(SecureRandom).to receive(:alphanumeric).and_return('98765432')
        Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :ended)
    
        
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Minhas reservas'
        click_on 'Quarto Zelda'
        click_on 'Avaliar estadia'
        
    
        #assert
        expect(page).to have_content('Conte-nos como foi sua experiência na Pousada da Nintendo')  
        expect(page).to have_content('Nome do quarto: Quarto Zelda') 
        expect(page).to have_content('Código da reserva: 98765432')
        expect(page).to have_content('Nota')
        expect(page).to have_content('Comentário')
        
    end

    it 'e falha ao tentar criar um review com nota em branco' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada da Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        allow(SecureRandom).to receive(:alphanumeric).and_return('98765432')
        reservation = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :ended)
    
        
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Minhas reservas'
        click_on 'Quarto Zelda'
        click_on 'Avaliar estadia'
        fill_in 'Comentário', with: 'Uma péssima pousada.'
        click_on 'Salvar'
        
    
        #assert
        expect(page).to have_content('Conte-nos como foi sua experiência na Pousada da Nintendo') 
        expect(page).to have_content('Nota não pode ficar em branco')  
        expect(page).to have_content('Nome do quarto: Quarto Zelda') 

        
    end

    it 'e falha ao tentar criar um review com comentário em branco' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada da Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        allow(SecureRandom).to receive(:alphanumeric).and_return('98765432')
        reservation = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :ended)
    
        
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Minhas reservas'
        click_on 'Quarto Zelda'
        click_on 'Avaliar estadia'
        choose('review_rating_3')
        fill_in 'Comentário', with: ''
        click_on 'Salvar'
        
    
        #assert
        expect(page).to have_content('Conte-nos como foi sua experiência na Pousada da Nintendo') 
        expect(page).to have_content('Avaliação não enviada, tente novamente')  
        expect(page).to have_content('Nome do quarto: Quarto Zelda') 

        
    end

    it 'e cria um review com sucesso' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada da Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        allow(SecureRandom).to receive(:alphanumeric).and_return('98765432')
        reservation = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :ended)
    
        
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Minhas reservas'
        click_on 'Quarto Zelda'
        click_on 'Avaliar estadia'
        choose('review_rating_3')
        fill_in 'Comentário', with: 'Uma péssima pousada.'
        click_on 'Salvar'
        
    
        #assert
        expect(current_path).to eq room_reservation_review_path(inn_one, room_one, reservation)
        expect(page).to have_content('Avaliação enviada com sucesso.')  
        expect(page).to have_content('Nome do quarto: Quarto Zelda') 
        expect(page).to have_content('Nota: 3')
        expect(page).to have_content('Comentário: Uma péssima pousada.')
        expect(page).to have_content('Sua Avaliação')  
        
    end

    it 'e vê a resposta do Owner' do
        #Arrange
        guest = Guest.create!(name: 'Bianca', cpf: '32132131221', email: 'bianca@guest.com', password: 'password')
        owner_one = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn_one = Inn.create!(trade_name: 'Pousada da Nintendo', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner_one.id)
        room_one = Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto inspirado em Legend of Zelda.', size: 30, guest: 3, daily_rate: 30, balcony: 'possui', air_conditioner: 'possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_one.id)  

        allow(SecureRandom).to receive(:alphanumeric).and_return('98765432')
        reservation = Reservation.create!(guest_number: 2, start_date: Date.today, final_date:  24.day.from_now, room_id: room_one.id,  guest_id: guest.id, total_price: 400, status: :ended)
        review = Review.create!(rating: 3, comment: 'Uma estadia média', reservation_id: reservation.id, reply: 'Você também foi um hóspede médio.') 
        
        #act
        login_as(guest, scope: :guest)
        visit(root_path)
        click_on 'Minhas reservas'
        click_on 'Quarto Zelda'
        click_on 'Ver avaliação'
        
       
        
    
        #assert
    
       
        expect(page).to have_content('Nome do quarto: Quarto Zelda') 
        expect(page).to have_content('Nota: 3')
        expect(page).to have_content('Uma estadia média')
        expect(page).to have_content('Sua Avaliação')  
        expect(page).to have_content('Resposta: Você também foi um hóspede médio.')  
        
    end
end