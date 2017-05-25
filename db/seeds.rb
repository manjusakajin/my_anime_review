# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Genre.create(name: "Historical")
Genre.create(name: "Action")
Genre.create(name: "Shounen")
Genre.create(name: "Adventure")
Genre.create(name: "Mecha")
Genre.create(name: "Slice of Life")
Genre.create(name: "Comedy")
Genre.create(name: "Romance")
Genre.create(name: "Sports")
Genre.create(name: "Drama")
Genre.create(name: "Science Fiction")
Genre.create(name: "Ecchi")
Genre.create(name: "Seinen/Mature")
Genre.create(name: "Fantasy")
Genre.create(name: "Shoujo")
Anime.create(name: "abc", introdution: "xxxyyyzzz", web_ratting: 3.5)
AnimeGenre.create(anime_id: 1,genre_id: 2)
AnimeGenre.create(anime_id: 1,genre_id: 1)
AnimeGenre.create(anime_id: 1,genre_id: 4)
AnimeGenre.create(anime_id: 1,genre_id: 5)

