# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090808163337) do

  create_table "hq_apps", :force => true do |t|
    t.integer  "hq_system_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_cages", :force => true do |t|
    t.integer  "hq_site_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_connected_nics", :force => true do |t|
    t.integer  "hq_netconnection_id"
    t.integer  "hq_nic_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_diskarrays", :force => true do |t|
    t.integer  "hq_site_id"
    t.integer  "hq_san_id"
    t.integer  "hq_rack_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_envs", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_firewalls", :force => true do |t|
    t.integer  "hq_site_id"
    t.integer  "hq_rack_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_netconnections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_nics", :force => true do |t|
    t.integer  "hq_remotenic_id"
    t.integer  "hq_nichaving_id"
    t.string   "hq_nichaving_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "ipaddr"
  end

  create_table "hq_procs", :force => true do |t|
    t.integer  "hq_task_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "hq_racks", :force => true do |t|
    t.integer  "hq_site_id"
    t.integer  "hq_cage_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_rsrc_usages", :force => true do |t|
    t.integer  "hq_proc_id"
    t.integer  "hq_rsrc_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_rsrcs", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_sans", :force => true do |t|
    t.integer  "hq_site_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_servers", :force => true do |t|
    t.integer  "hq_site_id"
    t.integer  "hq_rack_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_sites", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_slices", :force => true do |t|
    t.integer  "hq_san_id"
    t.integer  "hq_vserver_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "size"
    t.string   "mountpoint"
  end

  create_table "hq_switches", :force => true do |t|
    t.integer  "hq_site_id"
    t.integer  "hq_rack_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_systems", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_tasks", :force => true do |t|
    t.integer  "hq_app_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "hq_vlan_assignments", :force => true do |t|
    t.integer  "hq_nic_id"
    t.integer  "hq_vlan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_vlans", :force => true do |t|
    t.string   "tag"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_vnics", :force => true do |t|
    t.integer  "hq_vserver_id"
    t.integer  "hq_bridge_id"
    t.string   "name"
    t.string   "ipaddr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hq_vservers", :force => true do |t|
    t.integer  "hq_server_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ppt_classes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ppt_nodes", :force => true do |t|
    t.integer  "ppt_class_id"
    t.integer  "puppetized_node_id"
    t.string   "puppetized_node_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "syshq_nav_section_items", :force => true do |t|
    t.integer  "syshq_nav_section_id"
    t.boolean  "view"
    t.integer  "position"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cntrlr"
  end

  create_table "syshq_nav_sections", :force => true do |t|
    t.boolean  "view"
    t.integer  "position"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
