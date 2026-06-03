import Foundation

struct DashboardStats: Codable {
    let totalProducts: Int
    let totalIngredients: Int
    let totalSuppliers: Int
    let totalTransactions: Int
    let totalSales: Double
    let totalStockMovements: Int
}
