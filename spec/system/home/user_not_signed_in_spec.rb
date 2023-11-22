require 'rails_helper'

describe 'Usuário visita tela inicial de Pousada sem estar logado' do
    it 'e as 3 últimas pousadas' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada dos Jovens', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                    neighborhood: 'Centro', city: 'São Paulo', zip_code: '389434-923', payment_methods: 'Apenas pix',description: 'A melhor Pousada do mundo.', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                        check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        
        user_two = Owner.create!(name: 'André', last_name: 'Porteira', email: 'jovem@pousadaria.com', password: 'password')
        inn_two = Inn.create!(trade_name: 'Pousada Nerd', company_name: 'Pousada Nerd LTDA', registration_number: '545434684355435', phone: '32999-2232', email: 'pousada@nerd.com', address: 'Rua das Nerdes, 234', 
                    neighborhood: 'Aeroporto', city: 'Rio de Janeiro', zip_code: '239434-978', payment_methods: 'Apenas pix',description: 'A melhor Pousada Nerd', pet: 'permitidos', rules: 'Não pode achar que Han não atirou primeiro.',
                        check_in: '15:00', check_out: '12:00', status: "ativa", owner_id: user_two.id)
        
        user_three = Owner.create!(name: 'Bianca', last_name: 'Ros', email: 'bianca@pousadaria.com', password: 'password')
        inn_three = Inn.create!(trade_name: 'Pousada das Letras', company_name: 'Pousada das Letras LTDA', registration_number: '3689453321', phone: '3299922-2345', email: 'pousada@dasletras.com', address: 'Rua da UFJF, 500', neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', payment_methods: 'Apenas pix',description: 'A melhor Pousada do mundo.', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_three.id)
        
        user_four = Owner.create!(name: 'Isabel', last_name: 'Lopes', email: 'isabel@pousadaria.com', password: 'password')
        inn_four = Inn.create!(trade_name: 'Pousada da Isa', company_name: 'Pousada da Isabel LTDA', registration_number: '32999227839', phone: '32999227839-2345', email: 'contato@daisa.com', address: 'Rua das Couves, 10', neighborhood: 'PInheiros', city: 'São Paulo', zip_code: '389434-923', payment_methods: 'Apenas pix',description: 'A segunda melhor Pousada do mundo.', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_four.id)
        
        visit(root_path)


        within('#new_inns') do
            expect(page).to have_content('Pousada das Letras')
            expect(page).to have_content('Cidade: Juiz de Fora')
            expect(page).to have_content('Pousada Nerd')
            expect(page).to have_content('Cidade: Rio de Janeiro')
            expect(page).to have_content('Pousada da Isa')
            expect(page).to have_content('Cidade: São Paulo')
            expect(page).not_to have_content('Pousada dos Jovens')
        end
    end

    it 'e ve todas as outras pousadas' do
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
        inn_four = Inn.create!(trade_name: 'Pousada da Isa', company_name: 'Pousada da Isabel LTDA', registration_number: '32999227839', phone: '32999227839-2345', email: 'contato@daisa.com', address: 'Rua das Couves, 10', neighborhood: 'PInheiros', city: 'São Paulo', zip_code: '389434-923', description: 'A segunda melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.', check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user_four.id)
        
        visit(root_path)

        within('#all_inns') do
            expect(page).to have_content('Pousada dos Jovens')
            expect(page).to have_content('Cidade: São Paulo')
        end
    end

    it 'e clica no nome da pousada e vai pros detalhes da pousada' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada dos Digimons', company_name: 'Pousada da Digievolução LTDA', registration_number: '456789556778', phone: '23243423432', email: 'pousada@digievolucao.com', address: 'Rua do Tai, 010101', 
                    neighborhood: 'Zona Norte', city: 'Rio de Janeiro', zip_code: '59434-923', description: 'Uma pousada de outro mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode falar de Pokémon.',
                        check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        
        visit(root_path)         
        click_on 'Pousada dos Digimons'
        
        expect(page).to have_content('Detalhes da Pousada')
        expect(page).to have_content('Nome Fantasia: Pousada dos Digimons')
        expect(page).to have_content('Telefone: 23243423432')
        expect(page).to have_content('Email: pousada@digievolucao.com')
        expect(page).to have_content('Detalhes da Pousada')
        expect(page).to have_content('Endereço: Rua do Tai, 010101')
        expect(page).to have_content('Bairro: Zona Norte')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('CEP: 59434-923')
        expect(page).to have_content('Descrição: Uma pousada de outro mundo.')
        expect(page).to have_content('Formas de Pagamento: Apenas PIX')
        expect(page).to have_content('Animais: permitidos')
        expect(page).to have_content('Regras: Não pode falar de Pokémon.')
        expect(page).to have_content('Entrada: 12:00')
        expect(page).to have_content('Saída: 14:00')
        expect(page).to have_content('Status: ativa')
        expect(page).not_to have_content('Razão Social: Pousada da Digievolução LTDA')
        expect(page).not_to have_content('CNPJ: 456789556778')
        expect(current_path).to eq(inn_path(inn))
    end
end