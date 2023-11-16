require 'rails_helper'

describe 'Usuário visita tela inicial de Quartos' do
    it 'a partir do menu na index' do
        owner = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                    neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                        check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner.id)
        Room.create!(name: 'Quarto Pokémon', description: 'Descrição: Quarto idéntico ao quarto de Ash.', size: 20, guest: 2, daily_rate: 20, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'sim', tv: 'não possui tv', wardrobe: 'possui guarda-roupas', safe: 'possui cofre', accessible: 'quarto sem acessibilidade', inn_id: inn.id)  
        Room.create!(name: 'Quarto Zelda', description: 'Descrição: Quarto com decoração de Hyrule.', size: 40, guest: 3, daily_rate: 40, balcony: 'possui', air_conditioner: 'não possui ar condicionado', available: 'não', tv: 'possui tv', wardrobe: 'não possui guarda-roupas', safe: 'não possui cofre', accessible: 'quarto com acessibilidade', inn_id: inn.id)              
        
        login_as(owner, :scope => :owner)
        visit(root_path)
        click_on 'Quartos'
   
        expect(current_path).to eq rooms_path
        expect(page).to have_content('Seus Quartos')
        expect(page).to have_content('Cadastrar novo quarto')
        expect(page).to have_content('Nome: Quarto Pokémon')
        expect(page).to have_content('Descrição: Quarto idéntico ao quarto de Ash.')
        expect(page).to have_content('Nome: Quarto Zelda')
        expect(page).to have_content('Descrição: Quarto com decoração de Hyrule.')
        
    end
    it 'e não tem quartos cadastrados' do
        owner = Owner.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        inn = Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                    neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                        check_in: '12:00', check_out: '14:00', status: "ativa", owner_id: owner.id)
     
        login_as(owner, :scope => :owner)
        visit(root_path)
        click_on 'Quartos'
   
        expect(current_path).to eq rooms_path
        expect(page).to have_content('Seus Quartos')
        expect(page).to have_content('Não existem quartos cadastrados.')
        
    end

end