require 'rails_helper'

describe 'Usuário visita tela inicial de Pousada sem estar logado' do
    it 'e vê listagem de pousadas' do
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                    neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                        check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user.id)
        room = Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)
        Price.create!(new_rate: 230, start_date: '2023-03-02', final_date: '2023-03-05', room_id: room.id) 
        
        user_two = User.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', 
                    neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.',
                        check_in: '15:00', check_out: '12:00', status: "desativada", user_id: user_two.id)
        room_two = Room.create!(name: 'Quarto Star Wars', description: 'Quarto do Yoda.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', 
                                available: 'não', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'não possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn_two.id)
        Price.create!(new_rate: 290, start_date: '2023-04-01', final_date: '2023-04-02', room_id: room_two.id)   
        
        user_three = User.create!(name: 'Bianca', last_name: 'Ros', email: 'bianca@pousadaria.com', password: 'password')
        inn_three = Inn.create!(trade_name: 'Pousada das Letras', company_name: 'Pousada das Letras LTDA', registration_number: '3689453321', phone: '3299922-2345', email: 'pousada@dasletras.com', address: 'Rua da UFJF, 500', 
                    neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                        check_in: '12:00', check_out: '14:00', status: "ativa", user_id: user_three.id)
        room_three = Room.create!(name: 'Quarto do Alfabeto', description: 'Quarto com todas as letras do alfabeto', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'possui ar condicionado', 
                                available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto com acessibilidade', inn_id: inn_three.id)
        Price.create!(new_rate: 230, start_date: '2022-05-02', final_date: '2022-05-05', room_id: room_three.id)
        

        visit(root_path)
    

        expect(page).to have_content('Pousada dos Jovens')
        expect(page).to have_content('Cidade: São Paulo')
        expect(page).to have_content('Pousada das Letras')
        expect(page).to have_content('Cidade: Juiz de Fora')
        expect(page).not_to have_content('Pousada Nerd')
        expect(page).not_to have_content('Cidade: Rio de Janeiro')

    end
end