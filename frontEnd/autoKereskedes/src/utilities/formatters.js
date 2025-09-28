/**
 * Dátum formázása
 * @param {string|Date} date
 * @returns {string} például 2025.09.28.
 */
export function formatDate(date) {
  const d = new Date(date)
  return new Intl.DateTimeFormat("hu-HU").format(d)
}

/**
 * Rendszám formázása (ABC-123)
 * @param {string} plate
 * @returns {string}
 */
export function formatPlate(plate) {
  if (!plate) return ""
  return plate.toUpperCase().replace(/[^A-Z0-9]/g, "").replace(/(.{3})(.{3})/, "$1-$2")
}
