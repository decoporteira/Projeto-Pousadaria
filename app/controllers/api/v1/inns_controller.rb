class Api::V1::InnsController < Api::V1::ApiController
    
    def index
    # query = params['query']
    # inns = Inn.where("trade_name LIKE ? OR neighborhood LIKE ? OR city LIKE ? AND status = ", "%#{query}%", "%#{query}%", "%#{query}%", :ativa ).order(:trade_name)
        inns = Inn.where(status: :ativa).order(:trade_name)
        render status: 200, json: inns.as_json(except: [:created_at, :updated_at]) 
    end

    def rooms
        #Listagem de quartos de uma pousada: a partir do ID de uma pousada, uma lista com informações sobre os tipos de quartos disponíveis para hospedagem nesta pousada.

    end

    def show
        #Detalhes de uma pousada: a partir do ID de uma pousada, todos os detalhes da pousada exceto CNPJ e razão social. O retorno deve incluir a nota média da pousada a partir de suas avaliações. Caso não existam avaliações o campo deve vir em branco.

    end


    def reservation
        #Consulta de disponibilidade: informando um ID de um quarto, a data de entrada, data de saída e quantidade de hóspedes, deve ser possível verificar a disponibilidade para reserva. Em caso positivo deve ser retornado o valor da reserva, em caso negativo deve haver uma mensagem de erro no corpo da resposta.

    end
end