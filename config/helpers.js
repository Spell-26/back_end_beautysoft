//este archivo nos permite conectarnos con nuestra base de datos
const MySqli = require ('mysqli');

let conn = new MySqli({
    host : 'localhost',
    post: 3306,
    user: 'root',
    passwd: '',
    db: 'beautysoft'
});

let db = conn.emit(false, '');

module.exports = {
    database : db
};