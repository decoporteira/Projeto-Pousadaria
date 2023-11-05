require 'rails_helper'

describe 'Usuário entra página de criação do quarto' do
    it 'com sucesso' do
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                    neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                    status: "ativa", user_id: user.id,  check_in: '12:00', check_out: '14:00')
        visit(root_path)
        login(user)
        click_on 'Quartos'
        click_on 'Cadastrar novo quarto'
   
        expect(current_path).to eq new_room_path
        expect(page).to have_content('Cadastrar novo quarto')
        expect(page).to have_content('Nome')
        
    end
    it 'e cadastra um quarto com sucesso' do
        user = User.create!(name: 'Deco', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password')
        Inn.create!(trade_name: 'Pousada de Teste', company_name: 'Pousada de Teste LTDA', registration_number: '5454354355435', phone: '23243423432', email: 'pousada@amores.com', address: 'Rua das Covas, 123', 
                    neighborhood: 'Centro', city: 'Juiz de Fora', zip_code: '389434-923', description: 'A melhor Pousada do mundo.', payment_methods: 'Apenas PIX', pet: 'permitidos', rules: 'Não pode ouvir música alta.',
                    status: "ativa", user_id: user.id, check_in: '12:00', check_out: '14:00')
        visit(root_path)
        login(user)
        click_on 'Quartos'
        click_on 'Cadastrar novo quarto'
        fill_in 'Nome', with: 'Quarto Pokémon'
        fill_in 'Descrição', with: 'Quarto idéntico ao quarto de Ash.'
        fill_in 'Tamanho', with: 20
        fill_in 'Hóspedes', with: 2
        fill_in 'Diária', with: 20
        select 'Possui', from: 'Varanda'
        select 'Não Possui Ar Condicionado', from: 'Ar condicionado'
        select 'Não Possui Tv', from: 'Tv'
        select 'Possui Guarda Roupas', from: 'Guarda-roupas'
        select 'Possui Cofre', from: 'Cofre'
        select 'Quarto Com Acessibilidade', from: 'Acessibilidade'
        select 'Sim', from: 'Disponível'
        click_on 'Salvar'
        
        expect(page).to have_content('Quarto cadastrado com sucesso')
        expect(page).to have_content('Nome: Quarto Pokémon')
        expect(page).to have_content('Descrição: Quarto idéntico ao quarto de Ash.')
        expect(page).to have_content('Diária: R$ 20,00')
        # expect(page).to have_content('Hóspedes: 2')
        # expect(page).to have_content('Tamanho: 20')
        # expect(page).to have_content('Varanda: possui')
        # expect(page).to have_content('Ar condicionado: não possui ar condicionado')
        # expect(page).to have_content('Tv: não possui tv')
        # expect(page).to have_content('Guarda-roupas: possui guarda-roupas ')
        # expect(page).to have_content('Cofre: possui cofre')
        # expect(page).to have_content('Acessibilidade: quarto com acessibilidade')
        # expect(page).to have_content('Disponibilidade: sim')
    
    end
end