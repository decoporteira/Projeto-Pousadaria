require 'rails_helper'

RSpec.describe Inn, type: :model do
    describe 'é válido?' do
        context 'presença' do 
            it 'é falso quando o campo Nome fantasia está em branco' do
                inn = Inn.new(trade_name: '', company_name:'Pousada Linda LTDA' , registration_number: '28938344/545-4343', phone:'882737-43123', email: 'contato@pousadalinda.com.br', address: 'Rua das Rochas, 34', neighborhood: 'Centro', city: 'Búzios', zip_code: '36040-030', description: 'A melhor Pousada de Búzios', payment_methods: 'Todos os cartões', pet: 'permitidos', rules: 'Proibido música alta', check_in: '14:00', check_out:'12:00', status: 'ativa')  
                
                    result = inn.valid?

                    expect(result).to eq false
            end
            it 'é falso quando o campo Razão Social está em branco' do
                inn = Inn.new(trade_name: 'Pousada Linda', company_name:'' , registration_number: '28938344/545-4343', phone:'882737-43123', email: 'contato@pousadalinda.com.br', address: 'Rua das Rochas, 34', neighborhood: 'Centro', city: 'Búzios', zip_code: '36040-030', description: 'A melhor Pousada de Búzios', payment_methods: 'Todos os cartões', pet: 'permitidos', rules: 'Proibido música alta', check_in: '14:00', check_out:'12:00', status: 'ativa')  
                
                    result = inn.valid?

                    expect(result).to eq false
            end
            it 'é falso quando o campo CNPJ está em branco' do
                inn = Inn.new(trade_name: 'Pousada Linda', company_name:'Pousada Linda LTDA' , registration_number: '', phone:'882737-43123', email: 'contato@pousadalinda.com.br', address: 'Rua das Rochas, 34', neighborhood: 'Centro', city: 'Búzios', zip_code: '36040-030', description: 'A melhor Pousada de Búzios', payment_methods: 'Todos os cartões', pet: 'permitidos', rules: 'Proibido música alta', check_in: '14:00', check_out:'12:00', status: 'ativa')  
                
                    result = inn.valid?

                    expect(result).to eq false
            end
        end
        context 'campo único' do 
            it 'é falso quando o campo CNPJ já foi cadastrado' do
                inn_one = Inn.new(trade_name: 'Pousada Linda', company_name:'Pousada Linda LTDA' , registration_number: '28938344/545-4343', phone:'882737-43123', email: 'contato@pousadalinda.com.br', address: 'Rua das Rochas, 34', neighborhood: 'Centro', city: 'Búzios', zip_code: '36040-030', description: 'A melhor Pousada de Búzios', payment_methods: 'Todos os cartões', pet: 'permitidos', rules: 'Proibido música alta', check_in: '14:00', check_out:'12:00', status: 'ativa')
                inn_two = Inn.new(trade_name: 'Pousada Do Golpe do Pix', company_name:'Pousada Do Golpe do Pix' , registration_number: '28938344/545-4343', phone:'171-171', email: 'contato@golpedopix.com.br', address: 'Rua das Cadeias, 171', neighborhood: 'Centro', city: 'Bangu', zip_code: '00000-000', description: 'Seu dinheiro é nosso', payment_methods: 'PIX', pet: 'permitidos', rules: 'não temos', check_in: '14:00', check_out:'12:00', status: 'ativa', )  
                
                    result = inn_two.valid?

                    expect(result).to eq false
            end
            it 'é falso quando tenta cadastrar duas pousadas' do
                owner = Owner.create!(name: 'André', last_name: 'Pereira', email: 'andre@pousadaria.com', password: 'password', role: 1)
             
                inn_one = Inn.create!(trade_name: 'Pousada Linda', company_name:'Pousada Linda LTDA' , registration_number: '28938344/545-4343', phone:'882737-43123', email: 'contato@pousadalinda.com.br', address: 'Rua das Rochas, 34', neighborhood: 'Centro', city: 'Búzios', zip_code: '36040-030', description: 'A melhor Pousada de Búzios', payment_methods: 'Todos os cartões', pet: 'permitidos', rules: 'Proibido música alta', check_in: '14:00', check_out:'12:00', status: 'ativa', owner_id: 1)
                inn_two = Inn.new(trade_name: 'Pousada Do Golpe do Pix', company_name:'Pousada Do Golpe do Pix' , registration_number: '2ew938344/545-4343', phone:'171-171', email: 'contato@golpedopix.com.br', address: 'Rua das Cadeias, 171', neighborhood: 'Centro', city: 'Bangu', zip_code: '00000-000', description: 'Seu dinheiro é nosso', payment_methods: 'PIX', pet: 'permitidos', rules: 'não temos', check_in: '14:00', check_out:'12:00', status: 'ativa', owner_id: owner)  
                
                    result = inn_two.valid?

                    expect(result).to eq false
            end
        end
    end
end