describe 'Usuário visita tela de edição do quarto' do
    it 'com sucesso' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        inn = Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                            neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                            check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', 
                            available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id) 
        
        visit(root_path)
        login(user)
        click_on 'Quartos'
        click_on 'Detalhes'
        click_on 'Editar'
                        
        
        expect(page).to have_content('Editar dados do quarto')
    end

    it 'e altera dados do quarto com sucesso' do
        user = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
        inn = Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                            neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                            check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: user.id)
        Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', 
                            available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id) 
        
        visit(root_path)
        login(user)
        click_on 'Quartos'
        click_on 'Detalhes'
        click_on 'Editar'
        fill_in 'Nome', with: 'Quarto do Luigi'
        fill_in 'Descrição', with: 'Quarto do Reino dos Cogumelos'
        fill_in 'Diária', with: 50
        click_on 'Salvar'
                        
        
        expect(page).to have_content('Nome: Quarto do Luigi')
        expect(page).to have_content('Descrição: Quarto do Reino dos Cogumelos')
        expect(page).to have_content('Diária: R$ 50,00')
    end
    
end