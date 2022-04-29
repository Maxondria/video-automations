# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_04_28_194410) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_table 'description_templates',
               id: :uuid,
               default: -> { 'gen_random_uuid()' },
               force: :cascade do |t|
    t.text 'template', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'name', null: false
  end

  create_table 'presenters',
               id: :uuid,
               default: -> { 'gen_random_uuid()' },
               force: :cascade do |t|
    t.string 'name', null: false
    t.string 'twitter_handle'
    t.string 'linked_in'
    t.string 'role'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'video_presenters',
               id: :uuid,
               default: -> { 'gen_random_uuid()' },
               force: :cascade do |t|
    t.uuid 'video_id', null: false
    t.uuid 'presenter_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['presenter_id'], name: 'index_video_presenters_on_presenter_id'
    t.index %w[video_id presenter_id],
            name: 'index_video_presenters_on_video_id_and_presenter_id',
            unique: true
    t.index ['video_id'], name: 'index_video_presenters_on_video_id'
  end

  create_table 'video_resources',
               id: :uuid,
               default: -> { 'gen_random_uuid()' },
               force: :cascade do |t|
    t.string 'url', null: false
    t.string 'title', null: false
    t.uuid 'video_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['video_id'], name: 'index_video_resources_on_video_id'
  end

  create_table 'videos',
               id: :uuid,
               default: -> { 'gen_random_uuid()' },
               force: :cascade do |t|
    t.string 'youtube_id', null: false
    t.string 'title', null: false
    t.string 'tags', default: [], array: true
    t.text 'chapter_markers'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.uuid 'description_template_id', null: false
    t.index ['description_template_id'],
            name: 'index_videos_on_description_template_id'
    t.index ['youtube_id'], name: 'index_videos_on_youtube_id', unique: true
  end

  add_foreign_key 'video_presenters', 'presenters'
  add_foreign_key 'video_presenters', 'videos'
  add_foreign_key 'video_resources', 'videos'
  add_foreign_key 'videos', 'description_templates'
end
