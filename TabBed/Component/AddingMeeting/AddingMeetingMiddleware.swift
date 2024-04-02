//
//  AddingMeetingMiddleware.swift
//  TabBed
//
//  Created by Даниил Суханов on 31.03.2024.
//

import Foundation

func addingMeetingMiddleware() -> Middleware<AddingMeetingAction> {
    let cheackerAddress = CheakerAdderessService(baseURL: NetworkingURL.cheakerAdderessService)
    let networkingService = RemoteDatabaseService(baseURL: NetworkingURL.remoteDatabaseService)
    return { action in
        switch action {
        case .correctAddress(let address):
            do {
                let model = try await cheackerAddress.checkCorrectAddress(address)
                guard let lon = Double(model.lon), let lat = Double(model.lat) else {
                    return .setPlace(nil)
                }
                return .setPlace(.init(name: model.name, longitude: lon, latitude: lat))
            } catch {
                print("correctAddress", String(describing: error))
                return .setError("Некорректный адрес.")
            }
        case .createMeeting(let participants, let place, let date, let time, let id):
            do {
                print(participants, place, date, time)
                guard let date, let time, let place, let id else {
                    return .setError("Не удалось")
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "y-M-d"
                var datetime = formatter.string(from: date)
                formatter.dateFormat = "HH:mm"
                datetime += " \(formatter.string(from: time))"
                print(datetime)
                formatter.dateFormat = "y-M-d HH:mm"
                guard let date = formatter.date(from: datetime) else {
                    return .setError("Datetime")
                }
                let model = ConfigurationMeeting(
                    date: Formatters.dateFormaterForNetworking.string(from: date),
                    place: .init(name: place.name, longitude: place.longitude, latitude: place.latitude),
                    participants: participants,
                    agentID: id
                )
                let _ = try await networkingService.createMeeting(model)
                return .setComplited(true)
            } catch {
                print("createMeeting", String(describing: error))
                return .setError("Не удалось создать встречу. Попробуйте позже.")
            }
        case .getAgents(let date):
            do {
                let netModels = try await networkingService.getAgents(longitude: 53, latitude: 37, dateTime: date)
                var models = [AgentModel]()
                for netModel in netModels {
                    let model = AgentModel(
                        name: netModel.name,
                        phone: netModel.phoneNumber,
                        descrition: netModel.description,
                        photo: try await netModel.photo.getImage(),
                        id: netModel.id
                    )
                    models.append(model)
                }
                return .setAgents(models)
            } catch {
                print("setCurrentAgent", error)
                return .setError("Неудалось получить агентов.")
            }
        case .getProducts :
            do {
                let netProducts = try await networkingService.getProducts()
                var products = [ProductModel]()
                for netProduct in netProducts {
                    let product = ProductModel(
                        name: netProduct.name,
                        id: netProduct.id,
                        description: netProduct.description,
                        image: try await netProduct.image.getImage(),
                        url: netProduct.url
                    )
                    products.append(product)
                }
                return .setProducts(products)
            } catch {
                return .setError("Нет продуктов")
            }
        default:
            break
        }
        return nil
    }
}
