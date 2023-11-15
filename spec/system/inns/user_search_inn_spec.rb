require 'rails_helper'

describe 'Usuário busca por uma pousada' do
    it 'a partir do menu' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        
        user_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.', check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: user_two.id)
        
        user_three = Owner.create!(name: 'Bianca', last_name: 'Ros', email: 'bianca@pousadaria.com', password: 'password')
        inn_three = Inn.create!(trade_name: 'Pousada das Letras', company_name: 'Pousada das Letras LTDA', registration_number: '3689453321', phone: '3299922-2345', email: 'pousada@dasletras.com', address: 'Rua da UFJF, 500', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_three.id)
        
        user_four = Owner.create!(name: 'Isabel', last_name: 'Lopes', email: 'isabel@pousadaria.com', password: 'password')
        inn_four = Inn.create!(trade_name: 'Pousada da Isa', company_name: 'Pousada da Isabel LTDA', registration_number: '32999227839', phone: '32999227839-2345', email: 'contato@daisa.com', address: 'Rua das Couves, 10', neighborhood: 'Pinheiros', city: 'São Paulo', zip_code: '389434-923', description: 'A segunda melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_four.id)
        
        visit root_path
        within('nav') do
            expect(page).to have_field('Buscar pousada')
            expect(page).to have_content('Buscar')
        end
    end

    it 'e encontra uma pousada usando o nome da pousada' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        
        user_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.', check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: user_two.id)
        
        user_three = Owner.create!(name: 'Bianca', last_name: 'Ros', email: 'bianca@pousadaria.com', password: 'password')
        inn_three = Inn.create!(trade_name: 'Pousada das Letras', company_name: 'Pousada das Letras LTDA', registration_number: '3689453321', phone: '3299922-2345', email: 'pousada@dasletras.com', address: 'Rua da UFJF, 500', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_three.id)
        
        user_four = Owner.create!(name: 'Isabel', last_name: 'Lopes', email: 'isabel@pousadaria.com', password: 'password')
        inn_four = Inn.create!(trade_name: 'Pousada da Isa', company_name: 'Pousada da Isabel LTDA', registration_number: '32999227839', phone: '32999227839-2345', email: 'contato@daisa.com', address: 'Rua das Couves, 10', neighborhood: 'Pinheiros', city: 'São Paulo', zip_code: '389434-923', description: 'A segunda melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_four.id)

        
        visit root_path
        fill_in 'Buscar pousada', with: 'Pousada Nerd'
        click_on 'Buscar'
        
        
        expect(page).to have_content '1 Pousada encontrada.'
        expect(page).to have_content "Pousada Nerd"
        
    end

    it 'e encontra uma pousada usando o bairro da pousada' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        
        user_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.', check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: user_two.id)
        
        user_three = Owner.create!(name: 'Bianca', last_name: 'Ros', email: 'bianca@pousadaria.com', password: 'password')
        inn_three = Inn.create!(trade_name: 'Pousada das Letras', company_name: 'Pousada das Letras LTDA', registration_number: '3689453321', phone: '3299922-2345', email: 'pousada@dasletras.com', address: 'Rua da UFJF, 500', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_three.id)
        
        user_four = Owner.create!(name: 'Isabel', last_name: 'Lopes', email: 'isabel@pousadaria.com', password: 'password')
        inn_four = Inn.create!(trade_name: 'Pousada da Isa', company_name: 'Pousada da Isabel LTDA', registration_number: '32999227839', phone: '32999227839-2345', email: 'contato@daisa.com', address: 'Rua das Couves, 10', neighborhood: 'Pinheiros', city: 'São Paulo', zip_code: '389434-923', description: 'A segunda melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_four.id)

        
        visit root_path
        fill_in 'Buscar pousada', with: 'Centro'
        click_on 'Buscar'

        expect(page).to have_content "Pousada dos Jovens"
        expect(page).to have_content 'Pousadas encontradas.'
        expect(page).to have_content "Pousada das Letras"
        expect(page).not_to have_content "Pousada da Isa"

    end

    it 'e encontra uma pousada usando a cidade da pousada' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        
        user_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.', check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: user_two.id)
        
        user_three = Owner.create!(name: 'Bianca', last_name: 'Ros', email: 'bianca@pousadaria.com', password: 'password')
        inn_three = Inn.create!(trade_name: 'Pousada das Letras', company_name: 'Pousada das Letras LTDA', registration_number: '3689453321', phone: '3299922-2345', email: 'pousada@dasletras.com', address: 'Rua da UFJF, 500', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_three.id)
        
        user_four = Owner.create!(name: 'Isabel', last_name: 'Lopes', email: 'isabel@pousadaria.com', password: 'password')
        inn_four = Inn.create!(trade_name: 'Pousada da Isa', company_name: 'Pousada da Isabel LTDA', registration_number: '32999227839', phone: '32999227839-2345', email: 'contato@daisa.com', address: 'Rua das Couves, 10', neighborhood: 'Pinheiros', city: 'São Paulo', zip_code: '389434-923', description: 'A segunda melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_four.id)
        
        visit root_path
        fill_in 'Buscar pousada', with: 'São Paulo'
        click_on 'Buscar'

        expect(page).to have_content "Pousada dos Jovens"
        expect(page).to have_content 'Pousadas encontradas.'
        expect(page).to have_content "Pousada da Isa"
        expect(page).not_to have_content "Pousada das Letras"
    end
end
