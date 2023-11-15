require 'rails_helper'

describe 'Usuário visita tela inicial de Pousada sem estar logado' do
    it 'e vê a lista de cidades' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                    neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                        check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        
        user_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', 
                    neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.',
                        check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: user_two.id)
        
        user_three = Owner.create!(name: 'Bianca', last_name: 'Ros', email: 'bianca@pousadaria.com', password: 'password')
        inn_three = Inn.create!(trade_name: 'Pousada das Letras', company_name: 'Pousada das Letras LTDA', registration_number: '3689453321', phone: '3299922-2345', email: 'pousada@dasletras.com', address: 'Rua da UFJF, 500', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_three.id)
        
        user_four = Owner.create!(name: 'Isabel', last_name: 'Lopes', email: 'isabel@pousadaria.com', password: 'password')
        inn_four = Inn.create!(trade_name: 'Pousada da Isa', company_name: 'Pousada da Isabel LTDA', registration_number: '32999227839', phone: '32999227839-2345', email: 'contato@daisa.com', address: 'Rua das Couves, 10', neighborhood: 'Pinheiros', city: 'São Paulo', zip_code: '389434-923', description: 'A segunda melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_four.id)
        
        visit(root_path)

        within('#cities') do
            expect(page).to have_content('Busque por cidade:')
            expect(page).to have_content('Rio de Janeiro')
            expect(page).to have_content('São Paulo')
            expect(page).to have_content('Juiz de Fora')
        end
    end

    it 'e clica em uma cidade' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        
        user_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.', check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: user_two.id)
        
        user_three = Owner.create!(name: 'Bianca', last_name: 'Ros', email: 'bianca@pousadaria.com', password: 'password')
        inn_three = Inn.create!(trade_name: 'Pousada das Letras', company_name: 'Pousada das Letras LTDA', registration_number: '3689453321', phone: '3299922-2345', email: 'pousada@dasletras.com', address: 'Rua da UFJF, 500', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_three.id)
        
        user_four = Owner.create!(name: 'Isabel', last_name: 'Lopes', email: 'isabel@pousadaria.com', password: 'password')
        inn_four = Inn.create!(trade_name: 'Pousada da Isa', company_name: 'Pousada da Isabel LTDA', registration_number: '32999227839', phone: '32999227839-2345', email: 'contato@daisa.com', address: 'Rua das Couves, 10', neighborhood: 'Pinheiros', city: 'São Paulo', zip_code: '389434-923', description: 'A segunda melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_four.id)
        
        visit(root_path)
        within('#cities') do
            click_on('São Paulo')
        end
        
        expect(page).to have_text("Nome: Pousada da Isa" + "\n" + "Nome: Pousada dos Jovens")
        expect(page).not_to have_content('Nome: Pousada das Letras')
        
    end
    it 'e clica em uma cidade e escolhe uma pousada' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        
        user_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', description: 'A melhor Pousada Nerd', payment_methods: 'Todos os cartões de crédito', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.', check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: user_two.id)
        
        user_three = Owner.create!(name: 'Bianca', last_name: 'Ros', email: 'bianca@pousadaria.com', password: 'password')
        inn_three = Inn.create!(trade_name: 'Pousada das Letras', company_name: 'Pousada das Letras LTDA', registration_number: '3689453321', phone: '3299922-2345', email: 'pousada@dasletras.com', address: 'Rua da UFJF, 500', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_three.id)
        
        user_four = Owner.create!(name: 'Isabel', last_name: 'Lopes', email: 'isabel@pousadaria.com', password: 'password')
        inn_four = Inn.create!(trade_name: 'Pousada da Isa', company_name: 'Pousada da Isabel LTDA', registration_number: '32999227839', phone: '32999227839-2345', email: 'contato@daisa.com', address: 'Rua das Couves, 10', neighborhood: 'Pinheiros', city: 'São Paulo', zip_code: '389434-923', description: 'A segunda melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_four.id)
        
        visit(root_path)
        within('#cities') do
            click_on('São Paulo')
        end
        click_on('Pousada dos Jovens')
        
        expect(page).to have_content('Detalhes da Pousada')
        expect(page).to have_content('Nome Fantasia: Pousada dos Jovens')
        expect(page).not_to have_content('CNPJ: 5454354355435')
        
        
    end
end