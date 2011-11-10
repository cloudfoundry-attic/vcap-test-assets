# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111108170209) do

  create_table "_default_auditing_options_", :id => false, :force => true do |t|
    t.string "a", :limit => 1
  end

  create_table "access$", :id => false, :force => true do |t|
    t.decimal "d_obj#",                 :null => false
    t.decimal "order#",                 :null => false
    t.raw     "columns", :limit => 126
    t.decimal "types",                  :null => false
  end

  add_index "access$", ["d_obj#", "order#"], :name => "i_access1"

# Could not dump table "alert_qt" because of following StandardError
#   Unknown type 'ALERT_TYPE' for column 'user_data'

  create_table "apply$_conf_hdlr_columns", :id => false, :force => true do |t|
    t.decimal "object_number"
    t.decimal "resolution_id"
    t.string  "column_name",   :limit => 30
    t.decimal "spare1"
  end

  add_index "apply$_conf_hdlr_columns", ["object_number", "column_name"], :name => "apply$_conf_hdlr_columns_unq1", :unique => true
  add_index "apply$_conf_hdlr_columns", ["resolution_id", "column_name"], :name => "apply$_conf_hdlr_columns_unq2", :unique => true

  create_table "apply$_constraint_columns", :id => false, :force => true do |t|
    t.string  "owner",           :limit => 30,   :null => false
    t.string  "name",            :limit => 30,   :null => false
    t.string  "constraint_name", :limit => 30,   :null => false
    t.string  "cname",           :limit => 30,   :null => false
    t.decimal "cpos"
    t.string  "long_cname",      :limit => 4000
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3",          :limit => 30
    t.string  "spare4",          :limit => 4000
  end

  add_index "apply$_constraint_columns", ["constraint_name"], :name => "apply$_constraint_columns_idx1"
  add_index "apply$_constraint_columns", ["owner", "name", "constraint_name", "cname"], :name => "apply$_constraint_columns_uix1", :unique => true

  create_table "apply$_dest_obj", :id => false, :force => true do |t|
    t.decimal "id",                           :null => false
    t.string  "source_owner",   :limit => 30, :null => false
    t.string  "source_name",    :limit => 30, :null => false
    t.decimal "type",                         :null => false
    t.string  "owner",          :limit => 30, :null => false
    t.string  "name",           :limit => 30, :null => false
    t.decimal "apply#"
    t.decimal "status"
    t.string  "error_notifier", :limit => 92
    t.decimal "spare1"
  end

  add_index "apply$_dest_obj", ["id"], :name => "i_apply_dest_obj1", :unique => true
  add_index "apply$_dest_obj", ["owner", "name", "type", "apply#"], :name => "i_apply_dest_obj3", :unique => true
  add_index "apply$_dest_obj", ["source_owner", "source_name", "type", "apply#"], :name => "i_apply_dest_obj2", :unique => true

  create_table "apply$_dest_obj_cmap", :id => false, :force => true do |t|
    t.decimal "dest_id",                         :null => false
    t.string  "src_long_cname",  :limit => 4000, :null => false
    t.string  "dest_long_cname", :limit => 4000
    t.decimal "spare1"
  end

  add_index "apply$_dest_obj_cmap", ["dest_id"], :name => "i_apply_dest_obj_cmap1"

  create_table "apply$_dest_obj_ops", :id => false, :force => true do |t|
    t.decimal "object_number",                                       :null => false
    t.string  "sname",                :limit => 30,                  :null => false
    t.string  "oname",                :limit => 30,                  :null => false
    t.string  "apply_name",           :limit => 30
    t.decimal "apply_operation",                                     :null => false
    t.string  "error_handler",        :limit => 1
    t.string  "user_apply_procedure", :limit => 98
    t.string  "assemble_lobs",        :limit => 1,  :default => "N"
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
  end

  add_index "apply$_dest_obj_ops", ["sname", "oname", "apply_operation", "apply_name"], :name => "i_apply_dest_obj_ops1", :unique => true

  create_table "apply$_error", :id => false, :force => true do |t|
    t.string   "local_transaction_id",  :limit => 22
    t.string   "source_transaction_id", :limit => 22
    t.string   "source_database",       :limit => 128
    t.string   "queue_owner",           :limit => 30,   :null => false
    t.string   "queue_name",            :limit => 30,   :null => false
    t.decimal  "apply#",                                :null => false
    t.decimal  "message_number"
    t.decimal  "message_count"
    t.decimal  "min_step_no"
    t.decimal  "recipient_id"
    t.string   "recipient_name",        :limit => 30
    t.decimal  "source_commit_scn"
    t.decimal  "error_number"
    t.string   "error_message",         :limit => 4000
    t.string   "aq_transaction_id",     :limit => 30
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.datetime "error_creation_time"
  end

  add_index "apply$_error", ["apply#"], :name => "streams$_apply_error_idx_2"
  add_index "apply$_error", ["local_transaction_id"], :name => "streams$_apply_error_unq", :unique => true, :tablespace => "sysaux"

  create_table "apply$_error_handler", :id => false, :force => true do |t|
    t.decimal "object_number"
    t.string  "method_name",       :limit => 92
    t.string  "resolution_column", :limit => 4000
    t.decimal "resolution_id"
    t.decimal "spare1"
  end

  add_index "apply$_error_handler", ["resolution_id"], :name => "apply$_error_handler_unq", :unique => true

  create_table "apply$_error_txn", :id => false, :force => true do |t|
    t.raw     "msg_id",               :limit => 16
    t.string  "local_transaction_id", :limit => 22
    t.decimal "txn_message_number"
  end

  add_index "apply$_error_txn", ["local_transaction_id", "txn_message_number"], :name => "streams$_apply_error_txn_unq", :unique => true, :tablespace => "sysaux"

  create_table "apply$_source_obj", :id => false, :force => true do |t|
    t.decimal "id",                            :null => false
    t.string  "owner",          :limit => 30,  :null => false
    t.string  "name",           :limit => 30,  :null => false
    t.decimal "type",                          :null => false
    t.string  "source_db_name", :limit => 128, :null => false
    t.string  "dblink",         :limit => 128
    t.decimal "inst_scn"
    t.decimal "ignore_scn"
    t.decimal "spare1"
  end

  add_index "apply$_source_obj", ["id"], :name => "i_apply_source_obj1", :unique => true
  add_index "apply$_source_obj", ["owner", "name", "type", "source_db_name", "dblink"], :name => "i_apply_source_obj2", :unique => true

  create_table "apply$_source_schema", :id => false, :force => true do |t|
    t.string  "source_db_name", :limit => 128, :null => false
    t.decimal "global_flag",                   :null => false
    t.string  "name",           :limit => 30
    t.string  "dblink",         :limit => 128
    t.decimal "inst_scn"
    t.decimal "spare1"
  end

  add_index "apply$_source_schema", ["source_db_name", "global_flag", "name", "dblink"], :name => "i_apply_source_schema1", :unique => true

  create_table "apply$_virtual_obj_cons", :id => false, :force => true do |t|
    t.string  "owner",  :limit => 30,   :null => false
    t.string  "name",   :limit => 30,   :null => false
    t.string  "powner", :limit => 30,   :null => false
    t.string  "pname",  :limit => 30,   :null => false
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3", :limit => 30
    t.string  "spare4", :limit => 4000
  end

  add_index "apply$_virtual_obj_cons", ["owner", "name", "powner", "pname"], :name => "i_apply_virtual_obj_cons", :unique => true

  create_table "approle$", :id => false, :force => true do |t|
    t.decimal "role#",                 :null => false
    t.string  "schema",  :limit => 30, :null => false
    t.string  "package", :limit => 30, :null => false
  end

  add_index "approle$", ["role#"], :name => "i_approle", :unique => true

# Could not dump table "aq$_alert_qt_g" because of following StandardError
#   Unknown type 'AQ$_SIG_PROP' for column 'sign'

# Could not dump table "aq$_alert_qt_h" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

# Could not dump table "aq$_alert_qt_i" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

  create_table "aq$_alert_qt_s", :primary_key => "subscriber_id", :force => true do |t|
    t.string  "queue_name",            :limit => 30,   :null => false
    t.string  "name",                  :limit => 30
    t.string  "address",               :limit => 1024
    t.decimal "protocol"
    t.decimal "subscriber_type"
    t.string  "rule_name",             :limit => 30
    t.string  "trans_name",            :limit => 61
    t.string  "ruleset_name",          :limit => 65
    t.string  "negative_ruleset_name", :limit => 65
  end

  create_table "aq$_alert_qt_t", :id => false, :force => true do |t|
    t.timestamp "next_date", :limit => 6,  :null => false
    t.string    "txn_id",    :limit => 30, :null => false
    t.raw       "msgid",     :limit => 16, :null => false
    t.decimal   "action"
  end

# Could not dump table "aq$_aq$_mem_mc_g" because of following StandardError
#   Unknown type 'AQ$_SIG_PROP' for column 'sign'

# Could not dump table "aq$_aq$_mem_mc_h" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

# Could not dump table "aq$_aq$_mem_mc_i" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

  create_table "aq$_aq$_mem_mc_s", :primary_key => "subscriber_id", :force => true do |t|
    t.string  "queue_name",            :limit => 30,   :null => false
    t.string  "name",                  :limit => 30
    t.string  "address",               :limit => 1024
    t.decimal "protocol"
    t.decimal "subscriber_type"
    t.string  "rule_name",             :limit => 30
    t.string  "trans_name",            :limit => 61
    t.string  "ruleset_name",          :limit => 65
    t.string  "negative_ruleset_name", :limit => 65
  end

  create_table "aq$_aq$_mem_mc_t", :id => false, :force => true do |t|
    t.timestamp "next_date", :limit => 6,  :null => false
    t.string    "txn_id",    :limit => 30, :null => false
    t.raw       "msgid",     :limit => 16, :null => false
    t.decimal   "action"
  end

# Could not dump table "aq$_kupc$datapump_quetab_g" because of following StandardError
#   Unknown type 'AQ$_SIG_PROP' for column 'sign'

# Could not dump table "aq$_kupc$datapump_quetab_h" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

# Could not dump table "aq$_kupc$datapump_quetab_i" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

  create_table "aq$_kupc$datapump_quetab_s", :primary_key => "subscriber_id", :force => true do |t|
    t.string  "queue_name",            :limit => 30,   :null => false
    t.string  "name",                  :limit => 30
    t.string  "address",               :limit => 1024
    t.decimal "protocol"
    t.decimal "subscriber_type"
    t.string  "rule_name",             :limit => 30
    t.string  "trans_name",            :limit => 61
    t.string  "ruleset_name",          :limit => 65
    t.string  "negative_ruleset_name", :limit => 65
  end

  create_table "aq$_kupc$datapump_quetab_t", :id => false, :force => true do |t|
    t.timestamp "next_date", :limit => 6,  :null => false
    t.string    "txn_id",    :limit => 30, :null => false
    t.raw       "msgid",     :limit => 16, :null => false
    t.decimal   "action"
  end

# Could not dump table "aq$_mem_mc" because of following StandardError
#   Unknown type 'ANYDATA' for column 'user_prop'

  create_table "aq$_message_types", :id => false, :force => true do |t|
    t.raw     "queue_oid",    :limit => 16,  :null => false
    t.string  "schema_name",  :limit => 30,  :null => false
    t.string  "queue_name",   :limit => 30,  :null => false
    t.string  "trans_name",   :limit => 61
    t.string  "destination",  :limit => 128, :null => false
    t.raw     "toid",         :limit => 16
    t.decimal "version"
    t.string  "verified",     :limit => 1
    t.decimal "properties"
    t.string  "network_name", :limit => 256
  end

  add_index "aq$_message_types", ["queue_oid", "schema_name", "queue_name", "destination", "trans_name"], :name => "aq$_msgtypes_unique", :unique => true

  create_table "aq$_pending_messages", :id => false, :force => true do |t|
    t.decimal "sequence"
    t.raw     "msgid",    :limit => 16
    t.decimal "copy"
    t.raw     "pmsgid",   :limit => 16
    t.string  "txnid",    :limit => 22
    t.decimal "flags"
  end

  add_index "aq$_pending_messages", ["sequence"], :name => "aq$_pending_messages_i"

  create_table "aq$_propagation_status", :id => false, :force => true do |t|
    t.decimal "queue_id",                    :null => false
    t.string  "destination",  :limit => 128, :null => false
    t.decimal "sequence"
    t.decimal "status"
    t.string  "txnid",        :limit => 22
    t.decimal "destqueue_id",                :null => false
    t.decimal "flags"
  end

  create_table "aq$_publisher", :id => false, :force => true do |t|
    t.decimal "pub_id",                           :null => false
    t.decimal "queue_id",                         :null => false
    t.string  "p_name",           :limit => 30
    t.string  "p_address",        :limit => 1024
    t.decimal "p_protocol"
    t.string  "p_rule_name",      :limit => 61
    t.string  "p_rule",           :limit => 2000
    t.string  "p_ruleset",        :limit => 61
    t.string  "p_transformation", :limit => 61
  end

  create_table "aq$_queue_statistics", :primary_key => "eventid", :force => true do |t|
    t.decimal "owner_inst"
    t.decimal "incarn_num"
  end

  create_table "aq$_queue_table_affinities", :primary_key => "table_objno", :force => true do |t|
    t.decimal "primary_instance",   :null => false
    t.decimal "secondary_instance", :null => false
    t.decimal "owner_instance",     :null => false
  end

# Could not dump table "aq$_replay_info" because of following StandardError
#   Unknown type 'AQ$_AGENT' for column 'agent'

# Could not dump table "aq$_scheduler$_event_qtab_g" because of following StandardError
#   Unknown type 'AQ$_SIG_PROP' for column 'sign'

# Could not dump table "aq$_scheduler$_event_qtab_h" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

# Could not dump table "aq$_scheduler$_event_qtab_i" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

  create_table "aq$_scheduler$_event_qtab_s", :primary_key => "subscriber_id", :force => true do |t|
    t.string  "queue_name",            :limit => 30,   :null => false
    t.string  "name",                  :limit => 30
    t.string  "address",               :limit => 1024
    t.decimal "protocol"
    t.decimal "subscriber_type"
    t.string  "rule_name",             :limit => 30
    t.string  "trans_name",            :limit => 61
    t.string  "ruleset_name",          :limit => 65
    t.string  "negative_ruleset_name", :limit => 65
  end

  create_table "aq$_scheduler$_event_qtab_t", :id => false, :force => true do |t|
    t.timestamp "next_date", :limit => 6,  :null => false
    t.string    "txn_id",    :limit => 30, :null => false
    t.raw       "msgid",     :limit => 16, :null => false
    t.decimal   "action"
  end

# Could not dump table "aq$_scheduler$_jobqtab_g" because of following StandardError
#   Unknown type 'AQ$_SIG_PROP' for column 'sign'

# Could not dump table "aq$_scheduler$_jobqtab_h" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

# Could not dump table "aq$_scheduler$_jobqtab_i" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

  create_table "aq$_scheduler$_jobqtab_s", :primary_key => "subscriber_id", :force => true do |t|
    t.string  "queue_name",            :limit => 30,   :null => false
    t.string  "name",                  :limit => 30
    t.string  "address",               :limit => 1024
    t.decimal "protocol"
    t.decimal "subscriber_type"
    t.string  "rule_name",             :limit => 30
    t.string  "trans_name",            :limit => 61
    t.string  "ruleset_name",          :limit => 65
    t.string  "negative_ruleset_name", :limit => 65
  end

  create_table "aq$_scheduler$_jobqtab_t", :id => false, :force => true do |t|
    t.timestamp "next_date", :limit => 6,  :null => false
    t.string    "txn_id",    :limit => 30, :null => false
    t.raw       "msgid",     :limit => 16, :null => false
    t.decimal   "action"
  end

  create_table "aq$_schedules", :id => false, :force => true do |t|
    t.raw      "oid",             :limit => 16,   :null => false
    t.string   "destination",     :limit => 128,  :null => false
    t.datetime "start_time"
    t.string   "duration",        :limit => 8
    t.string   "next_time",       :limit => 200
    t.string   "latency",         :limit => 8
    t.datetime "last_run"
    t.decimal  "jobno"
    t.decimal  "failures"
    t.string   "disabled",        :limit => 1
    t.datetime "error_time"
    t.string   "last_error_msg",  :limit => 4000
    t.datetime "cur_start_time"
    t.datetime "next_run"
    t.string   "process_name",    :limit => 8
    t.decimal  "sid"
    t.decimal  "serial"
    t.decimal  "total_time"
    t.decimal  "total_msgs"
    t.decimal  "total_bytes"
    t.decimal  "total_windows"
    t.decimal  "win_msgs"
    t.decimal  "win_bytes"
    t.decimal  "max_num_per_win"
    t.decimal  "max_size"
    t.decimal  "instance"
    t.decimal  "spare1"
    t.string   "spare2",          :limit => 1024
  end

# Could not dump table "aq$_sys$service_metrics_tab_g" because of following StandardError
#   Unknown type 'AQ$_SIG_PROP' for column 'sign'

# Could not dump table "aq$_sys$service_metrics_tab_h" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

# Could not dump table "aq$_sys$service_metrics_tab_i" because of following StandardError
#   Unknown type 'ROWID' for column 'hint'

  create_table "aq$_sys$service_metrics_tab_s", :primary_key => "subscriber_id", :force => true do |t|
    t.string  "queue_name",            :limit => 30,   :null => false
    t.string  "name",                  :limit => 30
    t.string  "address",               :limit => 1024
    t.decimal "protocol"
    t.decimal "subscriber_type"
    t.string  "rule_name",             :limit => 30
    t.string  "trans_name",            :limit => 61
    t.string  "ruleset_name",          :limit => 65
    t.string  "negative_ruleset_name", :limit => 65
  end

  create_table "aq$_sys$service_metrics_tab_t", :id => false, :force => true do |t|
    t.timestamp "next_date", :limit => 6,  :null => false
    t.string    "txn_id",    :limit => 30, :null => false
    t.raw       "msgid",     :limit => 16, :null => false
    t.decimal   "action"
  end

# Could not dump table "aq_event_table" because of following StandardError
#   Unknown type 'AQ$_EVENT_MESSAGE' for column 'user_data'

# Could not dump table "aq_srvntfn_table" because of following StandardError
#   Unknown type 'AQ$_SRVNTFN_MESSAGE' for column 'user_data'

# Could not dump table "argument$" because of following StandardError
#   Unknown type 'LONG' for column 'default$'

  create_table "association$", :id => false, :force => true do |t|
    t.decimal "obj#",                :null => false
    t.decimal "property",            :null => false
    t.decimal "intcol#"
    t.decimal "statstype#"
    t.decimal "default_selectivity"
    t.decimal "default_cpu_cost"
    t.decimal "default_io_cost"
    t.decimal "default_net_cost"
    t.decimal "interface_version#"
    t.decimal "spare2"
  end

  add_index "association$", ["obj#", "intcol#"], :name => "assoc1", :unique => true
  add_index "association$", ["statstype#"], :name => "assoc2"

  create_table "atemptab$", :temporary => true, :id => false, :force => true do |t|
    t.decimal "id"
  end

  add_index "atemptab$", ["id"], :name => "atempind$"

  create_table "attrcol$", :id => false, :force => true do |t|
    t.decimal "obj#",                    :null => false
    t.decimal "intcol#",                 :null => false
    t.string  "name",    :limit => 4000, :null => false
  end

  add_index "attrcol$", ["obj#", "intcol#"], :name => "i_attrcol1", :unique => true

  create_table "attribute$", :id => false, :force => true do |t|
    t.raw     "toid",          :limit => 16,   :null => false
    t.decimal "version#",                      :null => false
    t.string  "name",          :limit => 30,   :null => false
    t.decimal "attribute#",                    :null => false
    t.raw     "attr_toid",     :limit => 16,   :null => false
    t.decimal "attr_version#",                 :null => false
    t.decimal "synobj#"
    t.decimal "properties",                    :null => false
    t.decimal "charsetid"
    t.decimal "charsetform"
    t.decimal "length"
    t.decimal "precision#"
    t.decimal "scale"
    t.string  "externname",    :limit => 4000
    t.decimal "xflags"
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
    t.decimal "spare4"
    t.decimal "spare5"
    t.decimal "setter"
    t.decimal "getter"
  end

  add_index "attribute$", ["toid", "version#", "attribute#"], :name => "i_attribute2", :unique => true
  add_index "attribute$", ["toid", "version#", "name"], :name => "i_attribute1", :unique => true

  create_table "attribute_transformations$", :id => false, :force => true do |t|
    t.decimal "transformation_id",                  :null => false
    t.decimal "attribute_number",                   :null => false
    t.string  "sql_expression",     :limit => 4000
    t.text    "xsl_transformation"
  end

  create_table "aud$", :id => false, :force => true do |t|
    t.decimal   "sessionid",                       :null => false
    t.decimal   "entryid",                         :null => false
    t.decimal   "statement",                       :null => false
    t.datetime  "timestamp#"
    t.string    "userid",          :limit => 30
    t.string    "userhost",        :limit => 128
    t.string    "terminal"
    t.decimal   "action#",                         :null => false
    t.decimal   "returncode",                      :null => false
    t.string    "obj$creator",     :limit => 30
    t.string    "obj$name",        :limit => 128
    t.string    "auth$privileges", :limit => 16
    t.string    "auth$grantee",    :limit => 30
    t.string    "new$owner",       :limit => 30
    t.string    "new$name",        :limit => 128
    t.string    "ses$actions",     :limit => 19
    t.decimal   "ses$tid"
    t.decimal   "logoff$lread"
    t.decimal   "logoff$pread"
    t.decimal   "logoff$lwrite"
    t.decimal   "logoff$dead"
    t.datetime  "logoff$time"
    t.string    "comment$text",    :limit => 4000
    t.string    "clientid",        :limit => 64
    t.string    "spare1"
    t.decimal   "spare2"
    t.raw       "obj$label",       :limit => 255
    t.raw       "ses$label",       :limit => 255
    t.decimal   "priv$used"
    t.decimal   "sessioncpu"
    t.timestamp "ntimestamp#",     :limit => 6
    t.decimal   "proxy$sid"
    t.string    "user$guid",       :limit => 32
    t.decimal   "instance#"
    t.string    "process#",        :limit => 16
    t.raw       "xid",             :limit => 8
    t.string    "auditid",         :limit => 64
    t.decimal   "scn"
    t.decimal   "dbid"
    t.text      "sqlbind"
    t.text      "sqltext"
  end

  add_index "aud$", ["sessionid", "ses$tid"], :name => "i_aud1"

  create_table "audit$", :id => false, :force => true do |t|
    t.decimal "user#",   :null => false
    t.decimal "proxy#"
    t.decimal "option#", :null => false
    t.decimal "success"
    t.decimal "failure"
  end

  add_index "audit$", ["user#", "proxy#", "option#"], :name => "i_audit", :unique => true

  create_table "audit_actions", :id => false, :force => true do |t|
    t.decimal "action",               :null => false
    t.string  "name",   :limit => 28, :null => false
  end

  add_index "audit_actions", ["action", "name"], :name => "i_audit_actions", :unique => true

  create_table "aux_stats$", :id => false, :force => true do |t|
    t.string  "sname", :limit => 30, :null => false
    t.string  "pname", :limit => 30, :null => false
    t.decimal "pval1"
    t.string  "pval2"
  end

  add_index "aux_stats$", ["sname", "pname"], :name => "i_aux_stats$", :unique => true

  create_table "aw$", :id => false, :force => true do |t|
    t.string  "awname",  :limit => 30
    t.decimal "owner#",                                               :null => false
    t.decimal "awseq#",                                               :null => false
    t.decimal "version"
    t.integer "oids",    :limit => 10, :precision => 10, :scale => 0
    t.integer "objs",    :limit => 10, :precision => 10, :scale => 0
    t.raw     "dict",    :limit => 8
  end

  add_index "aw$", ["awname", "owner#"], :name => "aw_ind$", :unique => true

  create_table "aw_obj$", :id => false, :force => true do |t|
    t.decimal "awseq#"
    t.integer "oid",      :limit => 20,  :precision => 20, :scale => 0
    t.string  "objname",  :limit => 256
    t.integer "gen#",     :limit => 10,  :precision => 10, :scale => 0
    t.integer "objtype",  :limit => 4,   :precision => 4,  :scale => 0
    t.string  "partname", :limit => 256
    t.binary  "objdef"
    t.binary  "objvalue"
    t.binary  "compcode"
  end

  add_index "aw_obj$", ["awseq#", "oid", "gen#"], :name => "i_aw_obj$", :unique => true, :tablespace => "sysaux"

  create_table "aw_prop$", :id => false, :force => true do |t|
    t.decimal "awseq#"
    t.integer "oid",      :limit => 20,  :precision => 20, :scale => 0
    t.string  "objname",  :limit => 256
    t.integer "gen#",     :limit => 10,  :precision => 10, :scale => 0
    t.string  "propname", :limit => 256
    t.decimal "proptype"
    t.binary  "propval"
  end

  add_index "aw_prop$", ["awseq#", "oid", "propname", "gen#"], :name => "i_aw_prop$", :tablespace => "sysaux"

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootstrap$", :id => false, :force => true do |t|
    t.decimal "line#",                    :null => false
    t.decimal "obj#",                     :null => false
    t.string  "sql_text", :limit => 4000, :null => false
  end

  create_table "cache_stats_0$", :id => false, :force => true do |t|
    t.decimal "dataobj#",                                      :null => false
    t.decimal "inst_id",                                       :null => false
    t.decimal "cached_avg"
    t.decimal "cached_sqr_avg"
    t.integer "cached_no",      :precision => 38, :scale => 0
    t.integer "cached_seq_no",  :precision => 38, :scale => 0
    t.decimal "chr_avg"
    t.decimal "chr_sqr_avg"
    t.integer "chr_no",         :precision => 38, :scale => 0
    t.integer "chr_seq_no",     :precision => 38, :scale => 0
    t.decimal "lgr_sum"
    t.decimal "lgr_last"
    t.decimal "phr_last"
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
    t.decimal "spare4"
    t.decimal "spare5"
  end

  add_index "cache_stats_0$", ["dataobj#", "inst_id"], :name => "i_cache_stats_0"

  create_table "cache_stats_1$", :id => false, :force => true do |t|
    t.decimal "dataobj#",                                      :null => false
    t.decimal "inst_id",                                       :null => false
    t.decimal "cached_avg"
    t.decimal "cached_sqr_avg"
    t.integer "cached_no",      :precision => 38, :scale => 0
    t.integer "cached_seq_no",  :precision => 38, :scale => 0
    t.decimal "chr_avg"
    t.decimal "chr_sqr_avg"
    t.integer "chr_no",         :precision => 38, :scale => 0
    t.integer "chr_seq_no",     :precision => 38, :scale => 0
    t.decimal "lgr_sum"
    t.decimal "lgr_last"
    t.decimal "phr_last"
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
    t.decimal "spare4"
    t.decimal "spare5"
  end

  add_index "cache_stats_1$", ["dataobj#", "inst_id"], :name => "i_cache_stats_1"

  create_table "ccol$", :id => false, :force => true do |t|
    t.decimal  "con#",                    :null => false
    t.decimal  "obj#",                    :null => false
    t.decimal  "col#",                    :null => false
    t.decimal  "pos#"
    t.decimal  "intcol#",                 :null => false
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",  :limit => 1000
    t.string   "spare5",  :limit => 1000
    t.datetime "spare6"
  end

  add_index "ccol$", ["con#", "col#"], :name => "i_ccol1"
  add_index "ccol$", ["con#", "intcol#"], :name => "i_ccol2", :unique => true

  create_table "cdc_change_columns$", :id => false, :force => true do |t|
    t.decimal  "change_table_obj#",               :null => false
    t.string   "column_name",       :limit => 30, :null => false
    t.datetime "created",                         :null => false
    t.decimal  "created_scn",                     :null => false
  end

  add_index "cdc_change_columns$", ["change_table_obj#", "column_name"], :name => "i_cdc_change_columns$", :unique => true

  create_table "cdc_change_sets$", :id => false, :force => true do |t|
    t.string   "set_name",              :limit => 30, :null => false
    t.string   "change_source_name",    :limit => 30, :null => false
    t.datetime "begin_date"
    t.datetime "end_date"
    t.decimal  "begin_scn"
    t.decimal  "end_scn"
    t.datetime "freshness_date"
    t.decimal  "freshness_scn"
    t.string   "advance_enabled",       :limit => 1
    t.string   "ignore_ddl",            :limit => 1
    t.datetime "created",                             :null => false
    t.string   "rollback_segment_name", :limit => 30
    t.string   "advancing",             :limit => 1,  :null => false
    t.string   "purging",               :limit => 1,  :null => false
    t.decimal  "lowest_scn"
    t.string   "tablespace",            :limit => 30
    t.decimal  "lm_session_id"
    t.string   "partial_tx_detected",   :limit => 1
    t.datetime "last_advance"
    t.datetime "last_purge"
    t.string   "stop_on_ddl",           :limit => 1,  :null => false
    t.string   "capture_enabled",       :limit => 1,  :null => false
    t.string   "capture_error",         :limit => 1,  :null => false
    t.string   "capture_name",          :limit => 30
    t.string   "queue_name",            :limit => 30
    t.string   "queue_table_name",      :limit => 30
    t.string   "apply_name",            :limit => 30
    t.decimal  "supplemental_procs"
    t.string   "set_description"
    t.string   "publisher",             :limit => 30
    t.string   "set_sequence",          :limit => 30
  end

  add_index "cdc_change_sets$", ["set_name"], :name => "i_cdc_change_sets$", :unique => true

  create_table "cdc_change_sources$", :id => false, :force => true do |t|
    t.string   "source_name",        :limit => 30,   :null => false
    t.decimal  "dbid"
    t.string   "logfile_location",   :limit => 2000
    t.string   "logfile_suffix",     :limit => 30
    t.string   "source_description"
    t.datetime "created",                            :null => false
    t.decimal  "source_type",                        :null => false
    t.string   "source_database",    :limit => 128
    t.string   "source_dbid",        :limit => 16
    t.decimal  "first_scn"
    t.string   "first_logfile",      :limit => 2000
    t.string   "logfile_format",     :limit => 2000
    t.string   "publisher",          :limit => 30
    t.string   "capture_name",       :limit => 30
    t.string   "capqueue_name",      :limit => 30
    t.string   "capqueue_tabname",   :limit => 30
    t.string   "source_enabled",     :limit => 1
  end

  add_index "cdc_change_sources$", ["source_name"], :name => "i_cdc_change_sources$", :unique => true

  create_table "cdc_change_tables$", :id => false, :force => true do |t|
    t.decimal  "obj#",                              :null => false
    t.string   "change_set_name",     :limit => 30, :null => false
    t.string   "source_schema_name",  :limit => 30, :null => false
    t.string   "source_table_name",   :limit => 30, :null => false
    t.string   "change_table_schema", :limit => 30, :null => false
    t.string   "change_table_name",   :limit => 30, :null => false
    t.datetime "created",                           :null => false
    t.decimal  "created_scn"
    t.decimal  "mvl_flag"
    t.string   "captured_values",     :limit => 1,  :null => false
    t.string   "mvl_temp_log",        :limit => 30
    t.string   "mvl_v7trigger",       :limit => 30
    t.datetime "last_altered"
    t.decimal  "lowest_scn",                        :null => false
    t.decimal  "mvl_oldest_rid"
    t.decimal  "mvl_oldest_pk"
    t.decimal  "mvl_oldest_seq"
    t.decimal  "mvl_oldest_oid"
    t.decimal  "mvl_oldest_new"
    t.datetime "mvl_oldest_rid_time"
    t.datetime "mvl_oldest_pk_time"
    t.datetime "mvl_oldest_seq_time"
    t.datetime "mvl_oldest_oid_time"
    t.datetime "mvl_oldest_new_time"
    t.string   "mvl_backcompat_view", :limit => 30
    t.string   "mvl_physmvl",         :limit => 30
    t.decimal  "highest_scn"
    t.datetime "highest_timestamp"
    t.decimal  "change_table_type",                 :null => false
    t.decimal  "major_version",                     :null => false
    t.decimal  "minor_version",                     :null => false
    t.decimal  "source_table_obj#"
    t.decimal  "source_table_ver"
  end

  add_index "cdc_change_tables$", ["obj#"], :name => "i_cdc_change_tables$", :unique => true

  create_table "cdc_propagated_sets$", :id => false, :force => true do |t|
    t.string "propagation_name",     :limit => 30, :null => false
    t.string "change_set_publisher", :limit => 30, :null => false
    t.string "change_set_name",      :limit => 30, :null => false
  end

  add_index "cdc_propagated_sets$", ["propagation_name"], :name => "i_cdc_propagated_sets$"

  create_table "cdc_propagations$", :id => false, :force => true do |t|
    t.string  "propagation_name",    :limit => 30,  :null => false
    t.string  "destqueue_publisher", :limit => 30,  :null => false
    t.string  "destqueue_name",      :limit => 30,  :null => false
    t.string  "staging_database",    :limit => 128, :null => false
    t.string  "sourceid_name",       :limit => 30,  :null => false
    t.decimal "source_class",                       :null => false
  end

  add_index "cdc_propagations$", ["propagation_name"], :name => "i_cdc_propagations$"

  create_table "cdc_subscribed_columns$", :id => false, :force => true do |t|
    t.decimal "handle",                          :null => false
    t.decimal "change_table_obj#",               :null => false
    t.string  "column_name",       :limit => 30, :null => false
  end

  add_index "cdc_subscribed_columns$", ["handle", "change_table_obj#", "column_name"], :name => "i_cdc_subscribed_columns$", :unique => true

  create_table "cdc_subscribed_tables$", :id => false, :force => true do |t|
    t.decimal "handle",                           :null => false
    t.decimal "change_table_obj#",                :null => false
    t.string  "view_name",         :limit => 30
    t.string  "view_status",       :limit => 1,   :null => false
    t.decimal "mv_flag"
    t.raw     "mv_colvec",         :limit => 128
  end

  add_index "cdc_subscribed_tables$", ["handle", "change_table_obj#"], :name => "i_cdc_subscribed_tables$", :unique => true

  create_table "cdc_subscribers$", :id => false, :force => true do |t|
    t.string   "subscription_name", :limit => 30, :null => false
    t.decimal  "handle",                          :null => false
    t.string   "set_name",          :limit => 30, :null => false
    t.string   "username",          :limit => 30, :null => false
    t.datetime "created",                         :null => false
    t.string   "status",            :limit => 1,  :null => false
    t.decimal  "earliest_scn",                    :null => false
    t.decimal  "latest_scn",                      :null => false
    t.string   "description"
    t.datetime "last_purged"
    t.datetime "last_extended"
    t.string   "mvl_invalid",       :limit => 1
    t.decimal  "reserved1"
  end

  add_index "cdc_subscribers$", ["subscription_name"], :name => "i_cdc_subscribers$", :unique => true

  create_table "cdc_system$", :id => false, :force => true do |t|
    t.decimal "major_version", :null => false
    t.decimal "minor_version", :null => false
  end

# Could not dump table "cdef$" because of following StandardError
#   Unknown type 'LONG' for column 'condition'

  create_table "clu$", :id => false, :force => true do |t|
    t.decimal  "obj#",                      :null => false
    t.decimal  "dataobj#"
    t.decimal  "ts#",                       :null => false
    t.decimal  "file#",                     :null => false
    t.decimal  "block#",                    :null => false
    t.decimal  "cols",                      :null => false
    t.decimal  "pctfree$",                  :null => false
    t.decimal  "pctused$",                  :null => false
    t.decimal  "initrans",                  :null => false
    t.decimal  "maxtrans",                  :null => false
    t.decimal  "size$"
    t.string   "hashfunc",  :limit => 30
    t.decimal  "hashkeys"
    t.decimal  "func"
    t.decimal  "extind"
    t.decimal  "flags"
    t.decimal  "degree"
    t.decimal  "instances"
    t.decimal  "avgchn"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.decimal  "spare4"
    t.string   "spare5",    :limit => 1000
    t.string   "spare6",    :limit => 1000
    t.datetime "spare7"
  end

  create_table "cluster_databases", :temporary => true, :id => false, :force => true do |t|
    t.string  "database_name", :limit => 128
    t.decimal "sparen1"
    t.decimal "sparen2"
    t.string  "sparevc1",      :limit => 4000
    t.string  "sparevc2",      :limit => 4000
  end

  create_table "cluster_instances", :temporary => true, :id => false, :force => true do |t|
    t.decimal "instance_number"
    t.string  "database_name",   :limit => 128
    t.string  "inst_name",       :limit => 4000
    t.string  "node_name",       :limit => 4000
    t.decimal "sparen1"
    t.decimal "sparen2"
    t.string  "sparevc1",        :limit => 4000
    t.string  "sparevc2",        :limit => 4000
  end

  create_table "cluster_nodes", :temporary => true, :id => false, :force => true do |t|
    t.string  "node_name", :limit => 4000
    t.decimal "sparen1"
    t.decimal "sparen2"
    t.string  "sparevc1",  :limit => 4000
    t.string  "sparevc2",  :limit => 4000
  end

# Could not dump table "col$" because of following StandardError
#   Unknown type 'LONG' for column 'default$'

  create_table "col_usage$", :id => false, :force => true do |t|
    t.decimal  "obj#"
    t.decimal  "intcol#"
    t.decimal  "equality_preds"
    t.decimal  "equijoin_preds"
    t.decimal  "nonequijoin_preds"
    t.decimal  "range_preds"
    t.decimal  "like_preds"
    t.decimal  "null_preds"
    t.datetime "timestamp"
  end

  add_index "col_usage$", ["obj#", "intcol#"], :name => "i_col_usage$", :unique => true

  create_table "collection$", :id => false, :force => true do |t|
    t.raw     "toid",          :limit => 16, :null => false
    t.decimal "version#",                    :null => false
    t.raw     "coll_toid",     :limit => 16, :null => false
    t.decimal "coll_version#",               :null => false
    t.raw     "elem_toid",     :limit => 16, :null => false
    t.decimal "elem_version#",               :null => false
    t.decimal "synobj#"
    t.decimal "properties",                  :null => false
    t.decimal "charsetid"
    t.decimal "charsetform"
    t.decimal "length"
    t.decimal "precision"
    t.decimal "scale"
    t.decimal "upper_bound"
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
  end

  create_table "coltype$", :id => false, :force => true do |t|
    t.decimal "obj#",                    :null => false
    t.decimal "col#",                    :null => false
    t.decimal "intcol#",                 :null => false
    t.raw     "toid",      :limit => 16, :null => false
    t.decimal "version#",                :null => false
    t.decimal "packed",                  :null => false
    t.decimal "intcols"
    t.raw     "intcol#s"
    t.decimal "flags"
    t.decimal "typidcol#"
    t.decimal "synobj#"
  end

  add_index "coltype$", ["obj#", "col#"], :name => "i_coltype1"
  add_index "coltype$", ["obj#", "intcol#"], :name => "i_coltype2", :unique => true

  create_table "com$", :id => false, :force => true do |t|
    t.decimal "obj#",                     :null => false
    t.decimal "col#"
    t.string  "comment$", :limit => 4000
  end

  add_index "com$", ["obj#", "col#"], :name => "i_com1", :unique => true

  create_table "con$", :id => false, :force => true do |t|
    t.decimal  "owner#",                 :null => false
    t.string   "name",   :limit => 30,   :null => false
    t.decimal  "con#",                   :null => false
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4", :limit => 1000
    t.string   "spare5", :limit => 1000
    t.datetime "spare6"
  end

  add_index "con$", ["con#"], :name => "i_con2", :unique => true
  add_index "con$", ["owner#", "name"], :name => "i_con1", :unique => true

  create_table "context$", :id => false, :force => true do |t|
    t.decimal "obj#",                  :null => false
    t.string  "schema",  :limit => 30, :null => false
    t.string  "package", :limit => 30, :null => false
    t.decimal "flags",                 :null => false
  end

  add_index "context$", ["obj#"], :name => "i_context", :unique => true

  create_table "dbms_alert_info", :id => false, :force => true do |t|
    t.string "name",    :limit => 30,   :null => false
    t.string "sid",     :limit => 30,   :null => false
    t.string "changed", :limit => 1
    t.string "message", :limit => 1800
  end

  create_table "dbms_apps_upg_working", :primary_key => "w_obj#", :force => true do |t|
    t.string  "w_name",      :limit => 30
    t.string  "w_namespace", :limit => 30
    t.decimal "lvl"
  end

  create_table "dbms_lock_allocated", :primary_key => "name", :force => true do |t|
    t.integer  "lockid",     :precision => 38, :scale => 0
    t.datetime "expiration"
  end

  create_table "dbms_upg_action_queue", :id => false, :force => true do |t|
    t.decimal "seq"
    t.string  "tabname", :limit => 30
    t.decimal "status"
    t.decimal "ext"
    t.decimal "low"
    t.decimal "high"
  end

  create_table "dbms_upg_cat_c0$", :primary_key => "c_obj#", :force => true do |t|
    t.decimal  "action",                     :null => false
    t.decimal  "c_mobj#",                    :null => false
    t.string   "c_name",      :limit => 100, :null => false
    t.decimal  "c_namespace",                :null => false
    t.decimal  "c_type#",                    :null => false
    t.datetime "c_ctime",                    :null => false
    t.datetime "c_mtime",                    :null => false
    t.datetime "c_stime",                    :null => false
    t.datetime "c_ctime_eq",                 :null => false
    t.datetime "c_mtime_eq",                 :null => false
    t.datetime "c_stime_eq",                 :null => false
    t.decimal  "c_status",                   :null => false
    t.raw      "c_toid",      :limit => 16
    t.raw      "c_mtoid",     :limit => 16
  end

  add_index "dbms_upg_cat_c0$", ["c_mobj#"], :name => "dbms_upg_cat_c0$_idx2"

  create_table "dbms_upg_cat_cs$", :primary_key => "c_obj#", :force => true do |t|
    t.decimal  "action",                     :null => false
    t.decimal  "c_mobj#",                    :null => false
    t.string   "c_name",      :limit => 100, :null => false
    t.decimal  "c_namespace",                :null => false
    t.decimal  "c_type#",                    :null => false
    t.datetime "c_ctime",                    :null => false
    t.datetime "c_mtime",                    :null => false
    t.datetime "c_stime",                    :null => false
    t.datetime "c_ctime_eq",                 :null => false
    t.datetime "c_mtime_eq",                 :null => false
    t.datetime "c_stime_eq",                 :null => false
    t.decimal  "c_status",                   :null => false
    t.raw      "c_toid",      :limit => 16
    t.raw      "c_mtoid",     :limit => 16
  end

  add_index "dbms_upg_cat_cs$", ["c_mobj#"], :name => "dbms_upg_cat_cs$_idx2"

  create_table "dbms_upg_cat_ct$", :primary_key => "c_obj#", :force => true do |t|
    t.decimal  "action",                     :null => false
    t.decimal  "c_mobj#",                    :null => false
    t.string   "c_name",      :limit => 100, :null => false
    t.decimal  "c_namespace",                :null => false
    t.decimal  "c_type#",                    :null => false
    t.datetime "c_ctime",                    :null => false
    t.datetime "c_mtime",                    :null => false
    t.datetime "c_stime",                    :null => false
    t.datetime "c_ctime_eq",                 :null => false
    t.datetime "c_mtime_eq",                 :null => false
    t.datetime "c_stime_eq",                 :null => false
    t.decimal  "c_status",                   :null => false
    t.raw      "c_toid",      :limit => 16
    t.raw      "c_mtoid",     :limit => 16
  end

  add_index "dbms_upg_cat_ct$", ["c_mobj#"], :name => "dbms_upg_cat_ct$_idx2"

  create_table "dbms_upg_change$", :id => false, :force => true do |t|
    t.string  "name",   :limit => 30, :null => false
    t.decimal "type#",                :null => false
    t.decimal "owner#",               :null => false
    t.decimal "save",                 :null => false
  end

  add_index "dbms_upg_change$", ["name", "type#"], :name => "dbms_upg_change$_idx1"

  create_table "dbms_upg_con_mapping", :id => false, :force => true do |t|
    t.decimal "ocon#"
    t.decimal "mcon#"
  end

  create_table "dbms_upg_debug", :id => false, :force => true do |t|
    t.string "name", :limit => 100, :null => false
    t.string "res",  :limit => 10
  end

  create_table "dbms_upg_invalidate", :primary_key => "i_obj#", :force => true do |t|
    t.decimal "layer"
  end

  create_table "dbms_upg_log$", :id => false, :force => true do |t|
    t.decimal  "n"
    t.string   "v",       :limit => 30
    t.datetime "en_time"
  end

# Could not dump table "dbms_upg_objauth_c0$" because of following StandardError
#   Unknown type 'ROWID' for column 'parent'

# Could not dump table "dbms_upg_objauth_cs$" because of following StandardError
#   Unknown type 'ROWID' for column 'parent'

# Could not dump table "dbms_upg_objauth_ct$" because of following StandardError
#   Unknown type 'ROWID' for column 'parent'

  create_table "dbms_upg_object$", :id => false, :force => true do |t|
    t.decimal "sequence#",                  :null => false
    t.string  "object_name", :limit => 100
    t.string  "object_type", :limit => 30
    t.string  "operation",   :limit => 30
    t.string  "status",      :limit => 30
    t.string  "message",     :limit => 100
  end

  create_table "dbms_upg_rls_c0$", :id => false, :force => true do |t|
    t.string  "name",        :limit => 30, :null => false
    t.decimal "namespace",                 :null => false
    t.string  "gname",       :limit => 30, :null => false
    t.string  "pname",       :limit => 30, :null => false
    t.decimal "stmt_type",                 :null => false
    t.decimal "check_opt",                 :null => false
    t.decimal "enable_flag",               :null => false
    t.string  "pfschma",     :limit => 30, :null => false
    t.string  "ppname",      :limit => 30
    t.string  "pfname",      :limit => 30, :null => false
    t.decimal "ptype"
    t.decimal "action",                    :null => false
  end

  create_table "dbms_upg_rls_cs$", :id => false, :force => true do |t|
    t.string  "name",        :limit => 30, :null => false
    t.decimal "namespace",                 :null => false
    t.string  "gname",       :limit => 30, :null => false
    t.string  "pname",       :limit => 30, :null => false
    t.decimal "stmt_type",                 :null => false
    t.decimal "check_opt",                 :null => false
    t.decimal "enable_flag",               :null => false
    t.string  "pfschma",     :limit => 30, :null => false
    t.string  "ppname",      :limit => 30
    t.string  "pfname",      :limit => 30, :null => false
    t.decimal "ptype"
    t.decimal "action",                    :null => false
  end

  create_table "dbms_upg_rls_ct$", :id => false, :force => true do |t|
    t.string  "name",        :limit => 30, :null => false
    t.decimal "namespace",                 :null => false
    t.string  "gname",       :limit => 30, :null => false
    t.string  "pname",       :limit => 30, :null => false
    t.decimal "stmt_type",                 :null => false
    t.decimal "check_opt",                 :null => false
    t.decimal "enable_flag",               :null => false
    t.string  "pfschma",     :limit => 30, :null => false
    t.string  "ppname",      :limit => 30
    t.string  "pfname",      :limit => 30, :null => false
    t.decimal "ptype"
    t.decimal "action",                    :null => false
  end

  create_table "dbms_upg_status$", :id => false, :force => true do |t|
    t.decimal  "sequence#",                    :null => false
    t.string   "source_schema", :limit => 100
    t.string   "target_schema", :limit => 100
    t.decimal  "source_user#"
    t.decimal  "target_user#"
    t.string   "dblink",        :limit => 100
    t.string   "status",        :limit => 30
    t.string   "message",       :limit => 100
    t.datetime "st_time"
    t.datetime "en_time"
  end

  create_table "dbms_upg_sysauth_c0$", :id => false, :force => true do |t|
    t.decimal "grantee#",   :null => false
    t.decimal "privilege#", :null => false
    t.decimal "sequence#",  :null => false
    t.decimal "option$"
    t.decimal "action",     :null => false
  end

  create_table "dbms_upg_sysauth_cs$", :id => false, :force => true do |t|
    t.decimal "grantee#",   :null => false
    t.decimal "privilege#", :null => false
    t.decimal "sequence#",  :null => false
    t.decimal "option$"
    t.decimal "action",     :null => false
  end

  create_table "dbms_upg_sysauth_ct$", :id => false, :force => true do |t|
    t.decimal "grantee#",   :null => false
    t.decimal "privilege#", :null => false
    t.decimal "sequence#",  :null => false
    t.decimal "option$"
    t.decimal "action",     :null => false
  end

  create_table "defrole$", :id => false, :force => true do |t|
    t.decimal "user#", :null => false
    t.decimal "role#", :null => false
  end

  add_index "defrole$", ["user#", "role#"], :name => "i_defrole1", :unique => true

# Could not dump table "defsubpart$" because of following StandardError
#   Unknown type 'LONG' for column 'hiboundval'

  create_table "defsubpartlob$", :id => false, :force => true do |t|
    t.decimal "bo#",                          :null => false
    t.decimal "intcol#",                      :null => false
    t.decimal "spart_position",               :null => false
    t.decimal "flags"
    t.string  "lob_spart_name", :limit => 34, :null => false
    t.decimal "lob_spart_ts#"
  end

  add_index "defsubpartlob$", ["bo#", "intcol#", "spart_position"], :name => "i_defsubpartlob$", :unique => true

  create_table "dependency$", :id => false, :force => true do |t|
    t.decimal  "d_obj#",      :null => false
    t.datetime "d_timestamp", :null => false
    t.decimal  "order#",      :null => false
    t.decimal  "p_obj#",      :null => false
    t.datetime "p_timestamp", :null => false
    t.decimal  "d_owner#"
    t.decimal  "property",    :null => false
    t.raw      "d_attrs"
    t.raw      "d_reason"
  end

  add_index "dependency$", ["d_obj#", "d_timestamp", "order#"], :name => "i_dependency1", :unique => true
  add_index "dependency$", ["p_obj#", "p_timestamp"], :name => "i_dependency2"

# Could not dump table "dim$" because of following StandardError
#   Unknown type 'LONG' for column 'dimtext'

  create_table "dimattr$", :id => false, :force => true do |t|
    t.decimal  "dimobj#",                    :null => false
    t.decimal  "levelid#",                   :null => false
    t.decimal  "detailobj#",                 :null => false
    t.decimal  "col#"
    t.string   "attname",    :limit => 30
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",     :limit => 1000
    t.datetime "spare4"
  end

  add_index "dimattr$", ["detailobj#", "col#"], :name => "i_dimattr$_2"
  add_index "dimattr$", ["dimobj#", "levelid#"], :name => "i_dimattr$_1"

  create_table "dimjoinkey$", :id => false, :force => true do |t|
    t.decimal  "dimobj#",                    :null => false
    t.decimal  "joinkeyid#",                 :null => false
    t.decimal  "keypos#",                    :null => false
    t.decimal  "hierid#"
    t.decimal  "levelid#"
    t.decimal  "detailobj#"
    t.decimal  "col#"
    t.decimal  "chdlevid#"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",     :limit => 1000
    t.datetime "spare4"
  end

  add_index "dimjoinkey$", ["detailobj#", "col#"], :name => "i_dimjoinkey$_2"
  add_index "dimjoinkey$", ["dimobj#", "joinkeyid#"], :name => "i_dimjoinkey$_1"

  create_table "dimlevel$", :id => false, :force => true do |t|
    t.decimal  "dimobj#",                                    :null => false
    t.decimal  "levelid#",                                   :null => false
    t.string   "levelname", :limit => 30
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",    :limit => 1000
    t.datetime "spare4"
    t.decimal  "flags",                     :default => 0.0
  end

  add_index "dimlevel$", ["dimobj#", "levelid#"], :name => "i_dimlevel$_1", :unique => true

  create_table "dimlevelkey$", :id => false, :force => true do |t|
    t.decimal  "dimobj#",                    :null => false
    t.decimal  "levelid#",                   :null => false
    t.decimal  "keypos#",                    :null => false
    t.decimal  "detailobj#"
    t.decimal  "col#"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",     :limit => 1000
    t.datetime "spare4"
  end

  add_index "dimlevelkey$", ["detailobj#", "col#"], :name => "i_dimlevelkey$_2"
  add_index "dimlevelkey$", ["dimobj#", "levelid#"], :name => "i_dimlevelkey$_1"

  create_table "dir$", :id => false, :force => true do |t|
    t.decimal "obj#",                    :null => false
    t.string  "audit$",  :limit => 38,   :null => false
    t.string  "os_path", :limit => 4000
  end

  add_index "dir$", ["obj#"], :name => "i_dir1", :unique => true

  create_table "dir$alert_history", :id => false, :force => true do |t|
    t.string   "alert_name",       :limit => 200
    t.decimal  "message_level"
    t.decimal  "action_id"
    t.decimal  "reason_id"
    t.datetime "last_time"
    t.datetime "next_time"
    t.datetime "action_time"
    t.string   "incarnation_info", :limit => 4000
    t.string   "job_name",         :limit => 100
    t.decimal  "sparen1"
    t.decimal  "sparen2"
    t.decimal  "sparen3"
    t.decimal  "sparen4"
    t.decimal  "sparen5"
    t.string   "sparevc1",         :limit => 4000
    t.string   "sparevc2",         :limit => 4000
    t.string   "sparevc3",         :limit => 4000
    t.string   "sparevc4",         :limit => 4000
    t.string   "sparevc5",         :limit => 4000
  end

  add_index "dir$alert_history", ["action_id"], :name => "i_dir$alert_history_action_id", :tablespace => "sysaux"
  add_index "dir$alert_history", ["action_time"], :name => "i_dir$alert_history_at", :tablespace => "sysaux"
  add_index "dir$alert_history", ["alert_name"], :name => "i_dir$alert_history_name", :tablespace => "sysaux"
  add_index "dir$alert_history", ["reason_id"], :name => "i_dir$alert_history_reason_id", :tablespace => "sysaux"

  create_table "dir$database_attributes", :id => false, :force => true do |t|
    t.string  "database_name",   :limit => 128
    t.string  "attribute_name",  :limit => 30
    t.string  "attribute_value", :limit => 4000
    t.decimal "sparen1"
    t.decimal "sparen2"
    t.decimal "sparen3"
    t.decimal "sparen4"
    t.decimal "sparen5"
    t.string  "sparevc1",        :limit => 4000
    t.string  "sparevc2",        :limit => 4000
    t.string  "sparevc3",        :limit => 4000
    t.string  "sparevc4",        :limit => 4000
    t.string  "sparevc5",        :limit => 4000
  end

  add_index "dir$database_attributes", ["database_name", "attribute_name"], :name => "i_dir$db_attributes_ui", :unique => true, :tablespace => "sysaux"

  create_table "dir$escalate_operations", :id => false, :force => true do |t|
    t.string   "escalation_id",    :limit => 200
    t.decimal  "alert_seq_id"
    t.string   "escalation",       :limit => 20
    t.string   "incarnation_info", :limit => 4000
    t.string   "instance_name",    :limit => 4000
    t.datetime "submit_time"
    t.decimal  "status"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "retry_time"
    t.decimal  "retry_count"
    t.string   "error_message",    :limit => 4000
    t.decimal  "sparen1"
    t.decimal  "sparen2"
    t.decimal  "sparen3"
    t.decimal  "sparen4"
    t.decimal  "sparen5"
    t.string   "sparevc1",         :limit => 4000
    t.string   "sparevc2",         :limit => 4000
    t.string   "sparevc3",         :limit => 4000
    t.string   "sparevc4",         :limit => 4000
    t.string   "sparevc5",         :limit => 4000
  end

  add_index "dir$escalate_operations", ["alert_seq_id"], :name => "i_dir$escalate_alert_seq_id", :tablespace => "sysaux"
  add_index "dir$escalate_operations", ["end_time"], :name => "i_dir$escalate_end_time", :tablespace => "sysaux"
  add_index "dir$escalate_operations", ["escalation_id", "status"], :name => "i_dir$escalate_ui", :unique => true, :tablespace => "sysaux"
  add_index "dir$escalate_operations", ["status"], :name => "i_dir$escalate_status", :tablespace => "sysaux"

  create_table "dir$instance_actions", :id => false, :force => true do |t|
    t.string   "job_name",      :limit => 100
    t.decimal  "action_type"
    t.string   "instance_name", :limit => 4000
    t.datetime "submit_time"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "error_message", :limit => 4000
    t.decimal  "sparen1"
    t.decimal  "sparen2"
    t.decimal  "sparen3"
    t.decimal  "sparen4"
    t.decimal  "sparen5"
    t.string   "sparevc1",      :limit => 4000
    t.string   "sparevc2",      :limit => 4000
    t.string   "sparevc3",      :limit => 4000
    t.string   "sparevc4",      :limit => 4000
    t.string   "sparevc5",      :limit => 4000
  end

  add_index "dir$instance_actions", ["action_type"], :name => "i_dir$instance_acttyp", :tablespace => "sysaux"
  add_index "dir$instance_actions", ["end_time"], :name => "i_dir$instance_end_time", :tablespace => "sysaux"
  add_index "dir$instance_actions", ["job_name"], :name => "i_dir$instance_job_name", :tablespace => "sysaux"

  create_table "dir$migrate_operations", :id => false, :force => true do |t|
    t.string   "job_name",         :limit => 100
    t.decimal  "alert_seq_id"
    t.string   "incarnation_info", :limit => 4000
    t.string   "service_name",     :limit => 4000
    t.string   "source_instance",  :limit => 4000
    t.string   "dest_instance",    :limit => 4000
    t.decimal  "session_count"
    t.decimal  "director_factor"
    t.datetime "submit_time"
    t.decimal  "status"
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal  "actual_count"
    t.string   "error_message",    :limit => 4000
    t.decimal  "sparen1"
    t.decimal  "sparen2"
    t.decimal  "sparen3"
    t.decimal  "sparen4"
    t.decimal  "sparen5"
    t.string   "sparevc1",         :limit => 4000
    t.string   "sparevc2",         :limit => 4000
    t.string   "sparevc3",         :limit => 4000
    t.string   "sparevc4",         :limit => 4000
    t.string   "sparevc5",         :limit => 4000
  end

  add_index "dir$migrate_operations", ["alert_seq_id"], :name => "i_dir$migrate_alert_seq_id", :tablespace => "sysaux"
  add_index "dir$migrate_operations", ["end_time"], :name => "i_dir$migrate_end_time", :tablespace => "sysaux"
  add_index "dir$migrate_operations", ["job_name", "status"], :name => "i_dir$migrate_ui", :unique => true, :tablespace => "sysaux"
  add_index "dir$migrate_operations", ["status"], :name => "i_dir$migrate_status", :tablespace => "sysaux"

  create_table "dir$node_attributes", :id => false, :force => true do |t|
    t.string  "node_name",       :limit => 4000
    t.string  "attribute_name",  :limit => 30
    t.string  "attribute_value", :limit => 4000
    t.decimal "sparen1"
    t.decimal "sparen2"
    t.decimal "sparen3"
    t.decimal "sparen4"
    t.decimal "sparen5"
    t.string  "sparevc1",        :limit => 4000
    t.string  "sparevc2",        :limit => 4000
    t.string  "sparevc3",        :limit => 4000
    t.string  "sparevc4",        :limit => 4000
    t.string  "sparevc5",        :limit => 4000
  end

  add_index "dir$node_attributes", ["attribute_name"], :name => "i_dir$node_attributes_attr", :tablespace => "sysaux"

  create_table "dir$quiesce_operations", :id => false, :force => true do |t|
    t.string   "job_name",         :limit => 100
    t.decimal  "alert_seq_id"
    t.decimal  "job_type"
    t.string   "incarnation_info", :limit => 4000
    t.string   "instance_name",    :limit => 4000
    t.datetime "submit_time"
    t.decimal  "status"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "error_message",    :limit => 4000
    t.decimal  "sparen1"
    t.decimal  "sparen2"
    t.decimal  "sparen3"
    t.decimal  "sparen4"
    t.decimal  "sparen5"
    t.string   "sparevc1",         :limit => 4000
    t.string   "sparevc2",         :limit => 4000
    t.string   "sparevc3",         :limit => 4000
    t.string   "sparevc4",         :limit => 4000
    t.string   "sparevc5",         :limit => 4000
  end

  add_index "dir$quiesce_operations", ["alert_seq_id"], :name => "i_dir$quiesce_alert_seq_id", :tablespace => "sysaux"
  add_index "dir$quiesce_operations", ["end_time"], :name => "i_dir$quiesce_end_time", :tablespace => "sysaux"
  add_index "dir$quiesce_operations", ["job_name", "status"], :name => "i_dir$quiesce_ui", :unique => true, :tablespace => "sysaux"
  add_index "dir$quiesce_operations", ["status"], :name => "i_dir$quiesce_status", :tablespace => "sysaux"

  create_table "dir$reason_strings", :id => false, :force => true do |t|
    t.decimal "reason_id"
    t.string  "reason",    :limit => 4000
    t.decimal "sparen1"
    t.decimal "sparen2"
    t.string  "sparevc1",  :limit => 4000
    t.string  "sparevc2",  :limit => 4000
  end

  add_index "dir$reason_strings", ["reason_id"], :name => "i_dir$reason_strings_ui", :unique => true, :tablespace => "sysaux"

  create_table "dir$resonate_operations", :id => false, :force => true do |t|
    t.string   "job_name",         :limit => 100
    t.string   "alert_name",       :limit => 200
    t.decimal  "job_type"
    t.string   "incarnation_info", :limit => 4000
    t.string   "database_name",    :limit => 128
    t.string   "instance_name",    :limit => 4000
    t.string   "node_name",        :limit => 4000
    t.datetime "submit_time"
    t.decimal  "status"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "error_message",    :limit => 4000
    t.decimal  "priority"
    t.decimal  "sparen1"
    t.decimal  "sparen2"
    t.decimal  "sparen3"
    t.decimal  "sparen4"
    t.decimal  "sparen5"
    t.string   "sparevc1",         :limit => 4000
    t.string   "sparevc2",         :limit => 4000
    t.string   "sparevc3",         :limit => 4000
    t.string   "sparevc4",         :limit => 4000
    t.string   "sparevc5",         :limit => 4000
  end

  add_index "dir$resonate_operations", ["alert_name"], :name => "i_dir$resonate_alert_name", :tablespace => "sysaux"
  add_index "dir$resonate_operations", ["end_time"], :name => "i_dir$resonate_end_time", :tablespace => "sysaux"
  add_index "dir$resonate_operations", ["job_name", "status"], :name => "i_dir$resonate_ui", :unique => true, :tablespace => "sysaux"
  add_index "dir$resonate_operations", ["status"], :name => "i_dir$resonate_status", :tablespace => "sysaux"

  create_table "dir$service_attributes", :id => false, :force => true do |t|
    t.decimal "service_id"
    t.string  "attribute_name",  :limit => 30
    t.string  "attribute_value", :limit => 4000
    t.decimal "sparen1"
    t.decimal "sparen2"
    t.decimal "sparen3"
    t.decimal "sparen4"
    t.decimal "sparen5"
    t.string  "sparevc1",        :limit => 4000
    t.string  "sparevc2",        :limit => 4000
    t.string  "sparevc3",        :limit => 4000
    t.string  "sparevc4",        :limit => 4000
    t.string  "sparevc5",        :limit => 4000
  end

  add_index "dir$service_attributes", ["attribute_name"], :name => "i_dir$service_attributes_attr", :tablespace => "sysaux"
  add_index "dir$service_attributes", ["service_id", "attribute_name"], :name => "i_dir$service_attributes_ui", :unique => true, :tablespace => "sysaux"

  create_table "dir$service_operations", :id => false, :force => true do |t|
    t.string   "job_name",         :limit => 100
    t.decimal  "alert_seq_id"
    t.decimal  "job_type"
    t.string   "incarnation_info", :limit => 4000
    t.string   "service_name",     :limit => 4000
    t.string   "instance_name",    :limit => 4000
    t.decimal  "director_factor"
    t.datetime "submit_time"
    t.decimal  "status"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "error_message",    :limit => 4000
    t.decimal  "sparen1"
    t.decimal  "sparen2"
    t.decimal  "sparen3"
    t.decimal  "sparen4"
    t.decimal  "sparen5"
    t.string   "sparevc1",         :limit => 4000
    t.string   "sparevc2",         :limit => 4000
    t.string   "sparevc3",         :limit => 4000
    t.string   "sparevc4",         :limit => 4000
    t.string   "sparevc5",         :limit => 4000
  end

  add_index "dir$service_operations", ["alert_seq_id"], :name => "i_dir$service_alert_seq_id", :tablespace => "sysaux"
  add_index "dir$service_operations", ["end_time"], :name => "i_dir$service_end_time", :tablespace => "sysaux"
  add_index "dir$service_operations", ["job_name", "status"], :name => "i_dir$service_ui", :unique => true, :tablespace => "sysaux"
  add_index "dir$service_operations", ["status"], :name => "i_dir$service_status", :tablespace => "sysaux"

  create_table "dir$victim_policy", :id => false, :force => true do |t|
    t.string  "user_name",            :limit => 30
    t.string  "policy_function_name", :limit => 98
    t.decimal "version"
    t.decimal "sparen1"
    t.decimal "sparen2"
    t.decimal "sparen3"
    t.decimal "sparen4"
    t.decimal "sparen5"
    t.decimal "sparen6"
    t.decimal "sparen7"
    t.string  "sparevc1",             :limit => 4000
    t.string  "sparevc2",             :limit => 4000
    t.string  "sparevc3",             :limit => 4000
    t.string  "sparevc4",             :limit => 4000
    t.string  "sparevc5",             :limit => 4000
  end

  create_table "dual", :id => false, :force => true do |t|
    t.string "dummy", :limit => 1
  end

  create_table "duc$", :id => false, :force => true do |t|
    t.string  "owner",      :limit => 30,                  :null => false
    t.string  "pack",       :limit => 30,                  :null => false
    t.string  "proc",       :limit => 30,                  :null => false
    t.decimal "field1",                   :default => 0.0
    t.decimal "operation#",                                :null => false
    t.decimal "seq",                                       :null => false
    t.string  "com",        :limit => 80
  end

  add_index "duc$", ["owner", "pack", "proc", "operation#"], :name => "i_duc", :unique => true

  create_table "enc$", :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "owner#"
    t.string  "mkeyid", :limit => 64
    t.decimal "encalg"
    t.decimal "intalg"
    t.raw     "colklc"
    t.decimal "klclen"
    t.decimal "flag"
  end

  add_index "enc$", ["obj#", "owner#"], :name => "enc_idx", :unique => true

  create_table "epg$_auth", :id => false, :force => true do |t|
    t.string  "dadname", :limit => 64, :null => false
    t.decimal "user#",                 :null => false
  end

  create_table "error$", :id => false, :force => true do |t|
    t.decimal "obj#",                                        :null => false
    t.decimal "sequence#",                  :default => 0.0, :null => false
    t.decimal "line",                                        :null => false
    t.decimal "position#",                                   :null => false
    t.decimal "textlength",                                  :null => false
    t.string  "text",       :limit => 4000,                  :null => false
    t.decimal "property"
    t.decimal "error#"
  end

  add_index "error$", ["obj#", "sequence#"], :name => "i_error1"

  create_table "expact$", :id => false, :force => true do |t|
    t.string  "owner",        :limit => 30,   :null => false
    t.string  "name",         :limit => 30,   :null => false
    t.string  "func_schema",  :limit => 30,   :null => false
    t.string  "func_package", :limit => 30,   :null => false
    t.string  "func_proc",    :limit => 30,   :null => false
    t.decimal "code",                         :null => false
    t.decimal "callorder"
    t.string  "callarg",      :limit => 1
    t.decimal "obj_type",                     :null => false
    t.string  "user_arg",     :limit => 2000
  end

  create_table "expdepact$", :id => false, :force => true do |t|
    t.decimal "obj#",                  :null => false
    t.string  "package", :limit => 30
    t.string  "schema",  :limit => 30
  end

  add_index "expdepact$", ["obj#", "package", "schema"], :name => "i_actobj", :unique => true

  create_table "expdepobj$", :id => false, :force => true do |t|
    t.decimal "d_obj#", :null => false
    t.decimal "p_obj#", :null => false
  end

  add_index "expdepobj$", ["d_obj#"], :name => "i_dependobj", :unique => true
  add_index "expdepobj$", ["p_obj#"], :name => "i_parentobj"

  create_table "expimp_tts_ct$", :id => false, :force => true do |t|
    t.string    "owner",     :limit => 30, :null => false
    t.string    "tablename", :limit => 30, :null => false
    t.text      "xmlinfo",                 :null => false
    t.timestamp "when",      :limit => 6,  :null => false
  end

  create_table "exppkgact$", :id => false, :force => true do |t|
    t.string  "package", :limit => 30,                     :null => false
    t.string  "schema",  :limit => 30,                     :null => false
    t.decimal "class",                                     :null => false
    t.decimal "level#",                :default => 1000.0, :null => false
  end

  add_index "exppkgact$", ["package", "schema", "class"], :name => "i_actpackage", :unique => true

  create_table "exppkgobj$", :id => false, :force => true do |t|
    t.string  "package", :limit => 30,                     :null => false
    t.string  "schema",  :limit => 30,                     :null => false
    t.decimal "class",                                     :null => false
    t.decimal "type#",                                     :null => false
    t.decimal "prepost"
    t.decimal "level#",                :default => 1000.0, :null => false
  end

  add_index "exppkgobj$", ["type#", "class"], :name => "i_objtype", :unique => true

  create_table "external_location$", :id => false, :force => true do |t|
    t.decimal "obj#",                     :null => false
    t.decimal "position",                 :null => false
    t.string  "dir",      :limit => 30
    t.string  "name",     :limit => 4000
  end

  add_index "external_location$", ["obj#", "position"], :name => "i_external_location1$", :unique => true

  create_table "external_tab$", :id => false, :force => true do |t|
    t.decimal "obj#",                       :null => false
    t.string  "default_dir",  :limit => 30, :null => false
    t.string  "type$",        :limit => 30, :null => false
    t.decimal "nr_locations",               :null => false
    t.decimal "reject_limit",               :null => false
    t.decimal "par_type",                   :null => false
    t.text    "param_clob"
    t.binary  "param_blob"
    t.decimal "property",                   :null => false
  end

  add_index "external_tab$", ["obj#"], :name => "i_external_tab1$", :unique => true

  create_table "fet$", :id => false, :force => true do |t|
    t.decimal "ts#",    :null => false
    t.decimal "file#",  :null => false
    t.decimal "block#", :null => false
    t.decimal "length", :null => false
  end

  create_table "fga$", :id => false, :force => true do |t|
    t.decimal "obj#",                                         :null => false
    t.string  "pname",       :limit => 30,                    :null => false
    t.string  "ptxt",        :limit => 4000
    t.string  "pfschma",     :limit => 30
    t.string  "ppname",      :limit => 30
    t.string  "pfname",      :limit => 30
    t.string  "pcol",        :limit => 30
    t.decimal "enable_flag",                                  :null => false
    t.decimal "stmt_type",                   :default => 1.0, :null => false
  end

  add_index "fga$", ["obj#", "pname"], :name => "i_fgap", :unique => true
  add_index "fga$", ["obj#"], :name => "i_fga"

# Could not dump table "fga_log$" because of following StandardError
#   Unknown type 'LONG' for column 'plhol'

  create_table "fgacol$", :id => false, :force => true do |t|
    t.decimal "obj#",                  :null => false
    t.string  "pname",   :limit => 30, :null => false
    t.decimal "intcol#",               :null => false
  end

  add_index "fgacol$", ["obj#", "pname", "intcol#"], :name => "i_fgacol", :unique => true

  create_table "fgr$_file_group_export_info", :id => false, :force => true do |t|
    t.raw      "version_guid",    :limit => 16,  :null => false
    t.string   "export_version",  :limit => 30,  :null => false
    t.string   "export_platform", :limit => 101, :null => false
    t.datetime "export_time",                    :null => false
    t.decimal  "export_scn"
    t.string   "source_db_name",  :limit => 128
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",          :limit => 30
    t.string   "spare4",          :limit => 128
  end

  add_index "fgr$_file_group_export_info", ["version_guid"], :name => "i_fgr$_file_group_export_info1", :unique => true

  create_table "fgr$_file_group_files", :id => false, :force => true do |t|
    t.string    "file_name",      :limit => 512,  :null => false
    t.string    "creator",        :limit => 30,   :null => false
    t.timestamp "creation_time",  :limit => 6,    :null => false
    t.string    "file_dir_obj",   :limit => 30,   :null => false
    t.raw       "version_guid",   :limit => 16,   :null => false
    t.decimal   "file_size"
    t.decimal   "file_blocksize"
    t.string    "file_type",      :limit => 32
    t.string    "user_comment",   :limit => 4000
    t.decimal   "spare1"
    t.decimal   "spare2"
    t.string    "spare3",         :limit => 30
    t.string    "spare4",         :limit => 128
  end

  add_index "fgr$_file_group_files", ["file_name", "version_guid"], :name => "i_fgr$_file_group_files1", :unique => true
  add_index "fgr$_file_group_files", ["version_guid"], :name => "i_fgr$_file_group_files2"

  create_table "fgr$_file_group_versions", :id => false, :force => true do |t|
    t.decimal   "version_id",                      :null => false
    t.decimal   "file_group_id",                   :null => false
    t.string    "creator",         :limit => 30,   :null => false
    t.timestamp "creation_time",   :limit => 6,    :null => false
    t.raw       "version_guid",    :limit => 16,   :null => false
    t.string    "version_name",    :limit => 30,   :null => false
    t.string    "user_comment",    :limit => 4000
    t.string    "default_dir_obj", :limit => 30
    t.decimal   "spare1"
    t.decimal   "spare2"
    t.string    "spare3",          :limit => 30
    t.string    "spare4",          :limit => 128
  end

  add_index "fgr$_file_group_versions", ["file_group_id", "version_id"], :name => "i_fgr$_file_group_versions2", :unique => true
  add_index "fgr$_file_group_versions", ["version_guid"], :name => "i_fgr$_file_group_versions3", :unique => true
  add_index "fgr$_file_group_versions", ["version_name", "file_group_id"], :name => "i_fgr$_file_group_versions1", :unique => true

  create_table "fgr$_file_groups", :id => false, :force => true do |t|
    t.decimal   "file_group_id",                   :null => false
    t.string    "keep_files",      :limit => 1,    :null => false
    t.decimal   "min_versions",                    :null => false
    t.decimal   "max_versions",                    :null => false
    t.decimal   "retention_days",                  :null => false
    t.string    "creator",         :limit => 30,   :null => false
    t.timestamp "creation_time",   :limit => 6,    :null => false
    t.string    "sequence_name",   :limit => 30,   :null => false
    t.string    "audit$",          :limit => 38,   :null => false
    t.string    "user_comment",    :limit => 4000
    t.string    "default_dir_obj", :limit => 30
    t.decimal   "spare1"
    t.decimal   "spare2"
    t.string    "spare3",          :limit => 30
    t.string    "spare4",          :limit => 128
  end

  add_index "fgr$_file_groups", ["file_group_id"], :name => "i_fgr$_file_groups1", :unique => true

  create_table "fgr$_table_info", :id => false, :force => true do |t|
    t.raw     "version_guid",    :limit => 16,  :null => false
    t.string  "schema_name",     :limit => 30,  :null => false
    t.string  "table_name",      :limit => 30,  :null => false
    t.string  "tablespace_name", :limit => 30
    t.decimal "scn"
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3",          :limit => 30
    t.string  "spare4",          :limit => 128
  end

  add_index "fgr$_table_info", ["schema_name", "table_name", "tablespace_name"], :name => "i_fgr$_table_info2"
  add_index "fgr$_table_info", ["table_name"], :name => "i_fgr$_table_info3"
  add_index "fgr$_table_info", ["version_guid", "schema_name", "table_name"], :name => "i_fgr$_table_info1", :unique => true

  create_table "fgr$_tablespace_info", :id => false, :force => true do |t|
    t.raw     "version_guid",    :limit => 16,  :null => false
    t.string  "tablespace_name", :limit => 30,  :null => false
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3",          :limit => 30
    t.string  "spare4",          :limit => 128
  end

  add_index "fgr$_tablespace_info", ["tablespace_name"], :name => "i_fgr$_tablespace_info2"
  add_index "fgr$_tablespace_info", ["version_guid", "tablespace_name"], :name => "i_fgr$_tablespace_info1", :unique => true

  create_table "file$", :id => false, :force => true do |t|
    t.decimal  "file#",                         :null => false
    t.decimal  "status$",                       :null => false
    t.decimal  "blocks",                        :null => false
    t.decimal  "ts#"
    t.decimal  "relfile#"
    t.decimal  "maxextend"
    t.decimal  "inc"
    t.decimal  "crscnwrp"
    t.decimal  "crscnbas"
    t.string   "ownerinstance", :limit => 30
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",        :limit => 1000
    t.datetime "spare4"
  end

  add_index "file$", ["file#"], :name => "i_file1", :unique => true
  add_index "file$", ["ts#", "relfile#"], :name => "i_file2", :unique => true

  create_table "fixed_obj$", :id => false, :force => true do |t|
    t.decimal  "obj#",                      :null => false
    t.datetime "timestamp",                 :null => false
    t.decimal  "flags"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",    :limit => 1000
    t.string   "spare5",    :limit => 1000
    t.datetime "spare6"
  end

  add_index "fixed_obj$", ["obj#"], :name => "i_fixed_obj$_obj#", :unique => true

  create_table "hier$", :id => false, :force => true do |t|
    t.decimal  "dimobj#",                  :null => false
    t.decimal  "hierid#",                  :null => false
    t.string   "hiername", :limit => 30
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",   :limit => 1000
    t.datetime "spare4"
  end

  add_index "hier$", ["dimobj#", "hierid#"], :name => "i_hier$_1", :unique => true

  create_table "hierlevel$", :id => false, :force => true do |t|
    t.decimal  "dimobj#",                    :null => false
    t.decimal  "hierid#",                    :null => false
    t.decimal  "pos#",                       :null => false
    t.decimal  "levelid#",                   :null => false
    t.decimal  "joinkeyid#"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",     :limit => 1000
    t.datetime "spare4"
  end

  add_index "hierlevel$", ["dimobj#", "hierid#"], :name => "i_hierlevel$_1"

  create_table "hist_head$", :id => false, :force => true do |t|
    t.decimal  "obj#",                      :null => false
    t.decimal  "col#",                      :null => false
    t.decimal  "bucket_cnt",                :null => false
    t.decimal  "row_cnt",                   :null => false
    t.decimal  "cache_cnt"
    t.decimal  "null_cnt"
    t.datetime "timestamp#"
    t.decimal  "sample_size"
    t.decimal  "minimum"
    t.decimal  "maximum"
    t.decimal  "distcnt"
    t.raw      "lowval",      :limit => 32
    t.raw      "hival",       :limit => 32
    t.decimal  "density"
    t.decimal  "intcol#",                   :null => false
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "avgcln"
    t.decimal  "spare3"
    t.decimal  "spare4"
  end

  add_index "hist_head$", ["obj#", "col#"], :name => "i_hh_obj#_col#"
  add_index "hist_head$", ["obj#", "intcol#"], :name => "i_hh_obj#_intcol#"

  create_table "histgrm$", :id => false, :force => true do |t|
    t.decimal "obj#",                     :null => false
    t.decimal "col#",                     :null => false
    t.decimal "row#"
    t.decimal "bucket",                   :null => false
    t.decimal "endpoint",                 :null => false
    t.decimal "intcol#",                  :null => false
    t.string  "epvalue",  :limit => 1000
    t.decimal "spare1"
    t.decimal "spare2"
  end

  add_index "histgrm$", ["obj#", "col#"], :name => "i_h_obj#_col#"

  create_table "hs$_base_caps", :primary_key => "cap_number", :force => true do |t|
    t.string "cap_description"
  end

  create_table "hs$_base_dd", :primary_key => "dd_table_id", :force => true do |t|
    t.string "dd_table_name", :limit => 30, :null => false
    t.string "dd_table_desc"
  end

  add_index "hs$_base_dd", ["dd_table_name"], :name => "hs$_base_dd_uk1", :unique => true

  create_table "hs$_class_caps", :primary_key => "fds_class_cap_id", :force => true do |t|
    t.decimal "fds_class_id",    :null => false
    t.decimal "cap_number",      :null => false
    t.decimal "context"
    t.string  "translation"
    t.decimal "additional_info"
  end

  add_index "hs$_class_caps", ["fds_class_id", "cap_number"], :name => "hs$_class_caps_uk1", :unique => true

  create_table "hs$_class_dd", :primary_key => "fds_class_dd_id", :force => true do |t|
    t.decimal "fds_class_id",                     :null => false
    t.decimal "dd_table_id",                      :null => false
    t.string  "translation_type", :limit => 1,    :null => false
    t.string  "translation_text", :limit => 4000
  end

  add_index "hs$_class_dd", ["fds_class_id", "dd_table_id"], :name => "hs$_class_dd_uk1", :unique => true

  create_table "hs$_class_init", :primary_key => "fds_class_init_id", :force => true do |t|
    t.decimal "fds_class_id",                  :null => false
    t.string  "init_value_name", :limit => 64, :null => false
    t.string  "init_value",                    :null => false
    t.string  "init_value_type", :limit => 1,  :null => false
  end

  add_index "hs$_class_init", ["fds_class_id", "init_value_name"], :name => "hs$_class_init_uk1", :unique => true

  create_table "hs$_fds_class", :primary_key => "fds_class_id", :force => true do |t|
    t.string "fds_class_name",     :limit => 30, :null => false
    t.string "fds_class_comments"
  end

  add_index "hs$_fds_class", ["fds_class_name"], :name => "hs$_fds_class_uk1", :unique => true

  create_table "hs$_fds_class_date", :id => false, :force => true do |t|
    t.decimal  "fds_class_id",   :null => false
    t.datetime "fds_class_date"
  end

  add_index "hs$_fds_class_date", ["fds_class_id"], :name => "hs$_fds_class_date_uk1", :unique => true

  create_table "hs$_fds_inst", :primary_key => "fds_inst_id", :force => true do |t|
    t.decimal "fds_class_id",                    :null => false
    t.string  "fds_inst_name",     :limit => 30, :null => false
    t.string  "fds_inst_comments"
  end

  add_index "hs$_fds_inst", ["fds_inst_name", "fds_class_id"], :name => "hs$_fds_inst_uk1", :unique => true

  create_table "hs$_inst_caps", :primary_key => "fds_inst_cap_id", :force => true do |t|
    t.decimal "fds_inst_id",     :null => false
    t.decimal "cap_number",      :null => false
    t.decimal "context"
    t.string  "translation"
    t.decimal "additional_info"
  end

  add_index "hs$_inst_caps", ["fds_inst_id", "cap_number"], :name => "hs$_inst_caps_uk1", :unique => true

  create_table "hs$_inst_dd", :primary_key => "fds_inst_dd_id", :force => true do |t|
    t.decimal "fds_inst_id",                      :null => false
    t.decimal "dd_table_id",                      :null => false
    t.string  "translation_type", :limit => 1,    :null => false
    t.string  "translation_text", :limit => 4000
  end

  add_index "hs$_inst_dd", ["fds_inst_id", "dd_table_id"], :name => "hs$_inst_dd_uk1", :unique => true

  create_table "hs$_inst_init", :primary_key => "fds_inst_init_id", :force => true do |t|
    t.decimal "fds_inst_id",                   :null => false
    t.string  "init_value_name", :limit => 64, :null => false
    t.string  "init_value",                    :null => false
    t.string  "init_value_type", :limit => 1,  :null => false
  end

  add_index "hs$_inst_init", ["fds_inst_id", "init_value_name"], :name => "hs$_inst_init_uk1", :unique => true

  create_table "icol$", :id => false, :force => true do |t|
    t.decimal  "obj#",                         :null => false
    t.decimal  "bo#",                          :null => false
    t.decimal  "col#",                         :null => false
    t.decimal  "pos#",                         :null => false
    t.decimal  "segcol#",                      :null => false
    t.decimal  "segcollength",                 :null => false
    t.decimal  "offset",                       :null => false
    t.decimal  "intcol#",                      :null => false
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",       :limit => 1000
    t.string   "spare5",       :limit => 1000
    t.datetime "spare6"
  end

  add_index "icol$", ["obj#"], :name => "i_icol1"

  create_table "icoldep$", :id => false, :force => true do |t|
    t.decimal "obj#",    :null => false
    t.decimal "bo#",     :null => false
    t.decimal "intcol#", :null => false
  end

  add_index "icoldep$", ["obj#"], :name => "i_icoldep$_obj"

  create_table "id_gens$", :id => false, :force => true do |t|
    t.decimal "total", :null => false
  end

# Could not dump table "idl_char$" because of following StandardError
#   Unknown type 'LONG' for column 'piece'

# Could not dump table "idl_sb4$" because of following StandardError
#   Unknown type 'UNDEFINED' for column 'piece'

  create_table "idl_ub1$", :id => false, :force => true do |t|
    t.decimal "obj#",                   :null => false
    t.decimal "part",                   :null => false
    t.decimal "version"
    t.decimal "piece#",                 :null => false
    t.decimal "length",                 :null => false
    t.raw     "piece",   :limit => nil, :null => false
  end

  add_index "idl_ub1$", ["obj#", "part", "version", "piece#"], :name => "i_idl_ub11", :unique => true

# Could not dump table "idl_ub2$" because of following StandardError
#   Unknown type 'UNDEFINED' for column 'piece'

  create_table "impdp_stats", :temporary => true, :id => false, :force => true do |t|
    t.string   "statid",  :limit => 30
    t.string   "type",    :limit => 1
    t.decimal  "version"
    t.decimal  "flags"
    t.string   "c1",      :limit => 30
    t.string   "c2",      :limit => 30
    t.string   "c3",      :limit => 30
    t.string   "c4",      :limit => 30
    t.string   "c5",      :limit => 30
    t.decimal  "n1"
    t.decimal  "n2"
    t.decimal  "n3"
    t.decimal  "n4"
    t.decimal  "n5"
    t.decimal  "n6"
    t.decimal  "n7"
    t.decimal  "n8"
    t.decimal  "n9"
    t.decimal  "n10"
    t.decimal  "n11"
    t.decimal  "n12"
    t.datetime "d1"
    t.raw      "r1",      :limit => 32
    t.raw      "r2",      :limit => 32
    t.string   "ch1",     :limit => 1000
  end

  add_index "impdp_stats", ["statid", "type", "c5", "c1", "c2", "c3", "c4", "version"], :name => "impdp_stats"

  create_table "incexp", :id => false, :force => true do |t|
    t.decimal  "owner#",                                             :null => false
    t.string   "name",   :limit => 30,                               :null => false
    t.decimal  "type#",                                              :null => false
    t.datetime "ctime"
    t.datetime "itime",                                              :null => false
    t.integer  "expid",  :limit => 3,  :precision => 3, :scale => 0, :null => false
  end

  add_index "incexp", ["owner#", "name", "type#"], :name => "i_incexp", :unique => true

  create_table "incfil", :id => false, :force => true do |t|
    t.integer  "expid",   :limit => 3,   :precision => 3, :scale => 0, :null => false
    t.string   "exptype", :limit => 1,                                 :null => false
    t.string   "expfile", :limit => 100,                               :null => false
    t.datetime "expdate",                                              :null => false
    t.string   "expuser", :limit => 30,                                :null => false
  end

  create_table "incvid", :id => false, :force => true do |t|
    t.integer "expid", :limit => 3, :precision => 3, :scale => 0, :null => false
  end

  create_table "ind$", :id => false, :force => true do |t|
    t.decimal  "obj#",                        :null => false
    t.decimal  "dataobj#"
    t.decimal  "ts#",                         :null => false
    t.decimal  "file#",                       :null => false
    t.decimal  "block#",                      :null => false
    t.decimal  "bo#",                         :null => false
    t.decimal  "indmethod#",                  :null => false
    t.decimal  "cols",                        :null => false
    t.decimal  "pctfree$",                    :null => false
    t.decimal  "initrans",                    :null => false
    t.decimal  "maxtrans",                    :null => false
    t.decimal  "pctthres$"
    t.decimal  "type#",                       :null => false
    t.decimal  "flags",                       :null => false
    t.decimal  "property",                    :null => false
    t.decimal  "blevel"
    t.decimal  "leafcnt"
    t.decimal  "distkey"
    t.decimal  "lblkkey"
    t.decimal  "dblkkey"
    t.decimal  "clufac"
    t.datetime "analyzetime"
    t.decimal  "samplesize"
    t.decimal  "rowcnt"
    t.decimal  "intcols",                     :null => false
    t.decimal  "degree"
    t.decimal  "instances"
    t.decimal  "trunccnt"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",      :limit => 1000
    t.string   "spare5",      :limit => 1000
    t.datetime "spare6"
  end

  add_index "ind$", ["obj#"], :name => "i_ind1", :unique => true

  create_table "ind_online$", :id => false, :force => true do |t|
    t.decimal "obj#",  :null => false
    t.decimal "type#", :null => false
    t.decimal "flags", :null => false
  end

  create_table "ind_stats$", :id => false, :force => true do |t|
    t.decimal  "obj#",                        :null => false
    t.decimal  "cachedblk"
    t.decimal  "cachehit"
    t.decimal  "logicalread"
    t.decimal  "rowcnt"
    t.decimal  "blevel"
    t.decimal  "leafcnt"
    t.decimal  "distkey"
    t.decimal  "lblkkey"
    t.decimal  "dblkkey"
    t.decimal  "clufac"
    t.datetime "analyzetime"
    t.decimal  "samplesize"
    t.decimal  "flags"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",      :limit => 1000
    t.string   "spare5",      :limit => 1000
    t.datetime "spare6"
  end

  add_index "ind_stats$", ["obj#"], :name => "i_ind_stats$_obj#", :unique => true

  create_table "indarraytype$", :id => false, :force => true do |t|
    t.decimal "obj#",          :null => false
    t.decimal "type",          :null => false
    t.decimal "basetypeobj#"
    t.decimal "arraytypeobj#", :null => false
    t.decimal "spare1"
    t.decimal "spare2"
  end

# Could not dump table "indcompart$" because of following StandardError
#   Unknown type 'LONG' for column 'hiboundval'

  create_table "indop$", :id => false, :force => true do |t|
    t.decimal "obj#",                   :null => false
    t.decimal "oper#",                  :null => false
    t.decimal "bind#",                  :null => false
    t.decimal "property",               :null => false
    t.string  "filt_nam", :limit => 30
    t.string  "filt_sch", :limit => 30
    t.string  "filt_typ", :limit => 30
  end

# Could not dump table "indpart$" because of following StandardError
#   Unknown type 'LONG' for column 'hiboundval'

  create_table "indpart_param$", :id => false, :force => true do |t|
    t.decimal "obj#",                       :null => false
    t.string  "parameters", :limit => 1000
  end

  add_index "indpart_param$", ["obj#"], :name => "i_indpart_param", :unique => true

# Could not dump table "indsubpart$" because of following StandardError
#   Unknown type 'LONG' for column 'hiboundval'

  create_table "indtypes$", :id => false, :force => true do |t|
    t.decimal "obj#",               :null => false
    t.decimal "implobj#",           :null => false
    t.decimal "property",           :null => false
    t.decimal "interface_version#"
  end

  create_table "invalidation_registry$", :id => false, :force => true do |t|
    t.decimal "regid"
    t.decimal "regflags"
    t.decimal "numobjs"
    t.raw     "objarray",      :limit => 512
    t.string  "plsqlcallback", :limit => 128
    t.decimal "changelag"
    t.string  "username",      :limit => 30
  end

  add_index "invalidation_registry$", ["regid"], :name => "i_invalidation_registry$"

  create_table "javaobj$", :id => false, :force => true do |t|
    t.decimal "obj#",                 :null => false
    t.string  "audit$", :limit => 38, :null => false
  end

  add_index "javaobj$", ["obj#"], :name => "i_javaobj1", :unique => true

  create_table "javasnm$", :id => false, :force => true do |t|
    t.string "short",    :limit => 30,   :null => false
    t.raw    "longname", :limit => nil,  :null => false
    t.string "longdbcs", :limit => 4000
  end

  add_index "javasnm$", ["short"], :name => "i_javasnm1", :unique => true

  create_table "jijoin$", :id => false, :force => true do |t|
    t.decimal "obj#",                       :null => false
    t.decimal "tab1obj#",                   :null => false
    t.decimal "tab1col#",                   :null => false
    t.decimal "tab2obj#",                   :null => false
    t.decimal "tab2col#",                   :null => false
    t.decimal "joinop",                     :null => false
    t.decimal "flags"
    t.decimal "tab1inst#", :default => 0.0
    t.decimal "tab2inst#", :default => 0.0
  end

  add_index "jijoin$", ["obj#"], :name => "i_jijoin$"
  add_index "jijoin$", ["tab1obj#", "tab1col#"], :name => "i2_jijoin$"
  add_index "jijoin$", ["tab2obj#", "tab2col#"], :name => "i3_jijoin$"

  create_table "jirefreshsql$", :id => false, :force => true do |t|
    t.decimal "iobj#",   :null => false
    t.decimal "tobj#",   :null => false
    t.text    "sqltext"
  end

  add_index "jirefreshsql$", ["iobj#", "tobj#"], :name => "i1_jirefreshsql$", :unique => true
  add_index "jirefreshsql$", ["tobj#"], :name => "i2_jirefreshsql$"

# Could not dump table "job$" because of following StandardError
#   Unknown type 'MLSLABEL' for column 'cur_ses_label'

  create_table "kopm$", :id => false, :force => true do |t|
    t.string  "name",     :limit => 30,  :null => false
    t.decimal "length",                  :null => false
    t.raw     "metadata", :limit => 255
  end

  add_index "kopm$", ["name"], :name => "i_kopm1", :unique => true

  create_table "ku$noexp_tab", :temporary => true, :id => false, :force => true do |t|
    t.string "obj_type", :limit => 30
    t.string "schema",   :limit => 30
    t.string "name",     :limit => 30
  end

  create_table "ku_noexp_tab", :id => false, :force => true do |t|
    t.string "obj_type", :limit => 30
    t.string "schema",   :limit => 30
    t.string "name",     :limit => 30
  end

# Could not dump table "kupc$datapump_quetab" because of following StandardError
#   Unknown type 'KUPC$_MESSAGE' for column 'user_data'

  create_table "library$", :id => false, :force => true do |t|
    t.decimal "obj#",                     :null => false
    t.string  "filespec", :limit => 2000
    t.decimal "property"
    t.string  "audit$",   :limit => 38,   :null => false
  end

  create_table "link$", :id => false, :force => true do |t|
    t.decimal  "owner#",                    :null => false
    t.string   "name",      :limit => 128,  :null => false
    t.datetime "ctime",                     :null => false
    t.string   "host",      :limit => 2000
    t.string   "userid",    :limit => 30
    t.string   "password",  :limit => 30
    t.decimal  "flag"
    t.string   "authusr",   :limit => 30
    t.string   "authpwd",   :limit => 30
    t.raw      "passwordx", :limit => 128
    t.raw      "authpwdx",  :limit => 128
  end

  add_index "link$", ["owner#", "name"], :name => "i_link1"

  create_table "lob$", :id => false, :force => true do |t|
    t.decimal "obj#",        :null => false
    t.decimal "col#",        :null => false
    t.decimal "intcol#",     :null => false
    t.decimal "lobj#",       :null => false
    t.decimal "part#",       :null => false
    t.decimal "ind#",        :null => false
    t.decimal "ts#",         :null => false
    t.decimal "file#",       :null => false
    t.decimal "block#",      :null => false
    t.decimal "chunk",       :null => false
    t.decimal "pctversion$", :null => false
    t.decimal "flags",       :null => false
    t.decimal "property",    :null => false
    t.decimal "retention",   :null => false
    t.decimal "freepools",   :null => false
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3"
  end

  add_index "lob$", ["lobj#"], :name => "i_lob2", :unique => true
  add_index "lob$", ["obj#", "intcol#"], :name => "i_lob1"

  create_table "lobcomppart$", :id => false, :force => true do |t|
    t.decimal "partobj#",    :null => false
    t.decimal "lobj#",       :null => false
    t.decimal "tabpartobj#", :null => false
    t.decimal "indpartobj#", :null => false
    t.decimal "part#",       :null => false
    t.decimal "defts#"
    t.decimal "defchunk",    :null => false
    t.decimal "defpctver$",  :null => false
    t.decimal "defflags",    :null => false
    t.decimal "defpro",      :null => false
    t.decimal "definiexts"
    t.decimal "defextsize"
    t.decimal "defminexts"
    t.decimal "defmaxexts"
    t.decimal "defextpct"
    t.decimal "deflists"
    t.decimal "defgroups"
    t.decimal "defbufpool"
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
  end

  add_index "lobcomppart$", ["lobj#", "part#"], :name => "i_lobcomppart_lobjpart$"
  add_index "lobcomppart$", ["partobj#"], :name => "i_lobcomppart$_partobj$", :unique => true

  create_table "lobfrag$", :id => false, :force => true do |t|
    t.decimal "fragobj#",                 :null => false
    t.decimal "parentobj#",               :null => false
    t.decimal "tabfragobj#",              :null => false
    t.decimal "indfragobj#",              :null => false
    t.decimal "frag#",                    :null => false
    t.string  "fragtype$",   :limit => 1
    t.decimal "ts#",                      :null => false
    t.decimal "file#",                    :null => false
    t.decimal "block#",                   :null => false
    t.decimal "chunk",                    :null => false
    t.decimal "pctversion$",              :null => false
    t.decimal "fragflags",                :null => false
    t.decimal "fragpro",                  :null => false
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
  end

  add_index "lobfrag$", ["fragobj#"], :name => "i_lobfrag$_fragobj$", :unique => true
  add_index "lobfrag$", ["parentobj#", "frag#"], :name => "i_lobfrag_parentobjfrag$", :unique => true

  create_table "loc$", :id => false, :force => true do |t|
    t.string  "location_name", :limit => 256, :null => false
    t.decimal "emon#"
    t.decimal "connection#"
  end

  create_table "log$", :id => false, :force => true do |t|
    t.decimal "btable#",                :null => false
    t.string  "colname",  :limit => 30, :null => false
    t.decimal "refcount",               :null => false
    t.decimal "ltable#",                :null => false
  end

  create_table "logmnr_buildlog", :primary_key => "initial_xid", :force => true do |t|
    t.string  "build_date",              :limit => 20
    t.decimal "db_txn_scnbas"
    t.decimal "db_txn_scnwrp"
    t.decimal "current_build_state"
    t.decimal "completion_status"
    t.decimal "marked_log_file_low_scn"
  end

  create_table "logmnr_interesting_cols", :id => false, :force => true do |t|
    t.decimal "obj#",                  :null => false
    t.decimal "intcol#",               :null => false
    t.string  "oname",   :limit => 30, :null => false
    t.string  "cname",   :limit => 30, :null => false
  end

  create_table "logmnrg_attrcol$", :id => false, :force => true do |t|
    t.decimal "intcol#"
    t.string  "name",    :limit => 4000
    t.decimal "obj#",                    :null => false
  end

  create_table "logmnrg_attribute$", :id => false, :force => true do |t|
    t.integer "version#",      :limit => 22, :precision => 22, :scale => 0
    t.string  "name",          :limit => 30
    t.integer "attribute#",    :limit => 22, :precision => 22, :scale => 0
    t.raw     "attr_toid",     :limit => 16
    t.integer "attr_version#", :limit => 22, :precision => 22, :scale => 0
    t.integer "properties",    :limit => 22, :precision => 22, :scale => 0
    t.raw     "toid",          :limit => 16,                                :null => false
  end

  create_table "logmnrg_ccol$", :id => false, :force => true do |t|
    t.decimal "con#"
    t.decimal "obj#"
    t.decimal "col#"
    t.decimal "pos#"
    t.decimal "intcol#", :null => false
  end

  create_table "logmnrg_cdef$", :id => false, :force => true do |t|
    t.decimal "con#"
    t.decimal "cols"
    t.decimal "type#"
    t.decimal "robj#"
    t.decimal "rcon#"
    t.decimal "enabled"
    t.decimal "defer"
    t.decimal "obj#",    :null => false
  end

  create_table "logmnrg_col$", :id => false, :force => true do |t|
    t.integer "col#",        :limit => 22, :precision => 22, :scale => 0
    t.integer "segcol#",     :limit => 22, :precision => 22, :scale => 0
    t.string  "name",        :limit => 30
    t.integer "type#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "length",      :limit => 22, :precision => 22, :scale => 0
    t.integer "precision#",  :limit => 22, :precision => 22, :scale => 0
    t.integer "scale",       :limit => 22, :precision => 22, :scale => 0
    t.integer "null$",       :limit => 22, :precision => 22, :scale => 0
    t.integer "intcol#",     :limit => 22, :precision => 22, :scale => 0
    t.integer "property",    :limit => 22, :precision => 22, :scale => 0
    t.integer "charsetid",   :limit => 22, :precision => 22, :scale => 0
    t.integer "charsetform", :limit => 22, :precision => 22, :scale => 0
    t.integer "spare1",      :limit => 22, :precision => 22, :scale => 0
    t.integer "spare2",      :limit => 22, :precision => 22, :scale => 0
    t.integer "obj#",        :limit => 22, :precision => 22, :scale => 0, :null => false
  end

  create_table "logmnrg_coltype$", :id => false, :force => true do |t|
    t.integer "col#",      :limit => 22, :precision => 22, :scale => 0
    t.integer "intcol#",   :limit => 22, :precision => 22, :scale => 0
    t.raw     "toid",      :limit => 16
    t.integer "version#",  :limit => 22, :precision => 22, :scale => 0
    t.integer "intcols",   :limit => 22, :precision => 22, :scale => 0
    t.integer "typidcol#", :limit => 22, :precision => 22, :scale => 0
    t.integer "obj#",      :limit => 22, :precision => 22, :scale => 0, :null => false
  end

  create_table "logmnrg_dictionary$", :id => false, :force => true do |t|
    t.string  "db_name",              :limit => 9
    t.integer "db_id",                :limit => 20,  :precision => 20, :scale => 0
    t.string  "db_created",           :limit => 20
    t.string  "db_dict_created",      :limit => 20
    t.integer "db_dict_scn",          :limit => 22,  :precision => 22, :scale => 0
    t.raw     "db_thread_map",        :limit => 8
    t.integer "db_txn_scnbas",        :limit => 22,  :precision => 22, :scale => 0
    t.integer "db_txn_scnwrp",        :limit => 22,  :precision => 22, :scale => 0
    t.integer "db_resetlogs_change#", :limit => 22,  :precision => 22, :scale => 0
    t.string  "db_resetlogs_time",    :limit => 20
    t.string  "db_version_time",      :limit => 20
    t.string  "db_redo_type_id",      :limit => 8
    t.string  "db_redo_release",      :limit => 60
    t.string  "db_character_set",     :limit => 30
    t.string  "db_version",           :limit => 64
    t.string  "db_status",            :limit => 64
    t.string  "db_global_name",       :limit => 128
    t.integer "db_dict_maxobjects",   :limit => 22,  :precision => 22, :scale => 0
    t.integer "db_dict_objectcount",  :limit => 22,  :precision => 22, :scale => 0, :null => false
  end

  create_table "logmnrg_icol$", :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "bo#"
    t.decimal "col#"
    t.decimal "pos#"
    t.decimal "segcol#"
    t.decimal "intcol#", :null => false
  end

  create_table "logmnrg_ind$", :id => false, :force => true do |t|
    t.integer "bo#",      :limit => 22, :precision => 22, :scale => 0
    t.integer "cols",     :limit => 22, :precision => 22, :scale => 0
    t.integer "type#",    :limit => 22, :precision => 22, :scale => 0
    t.decimal "flags"
    t.decimal "property"
    t.integer "obj#",     :limit => 22, :precision => 22, :scale => 0, :null => false
  end

  create_table "logmnrg_indcompart$", :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "dataobj#"
    t.decimal "bo#"
    t.decimal "part#",    :null => false
  end

  create_table "logmnrg_indpart$", :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "bo#"
    t.decimal "part#"
    t.decimal "ts#",   :null => false
  end

  create_table "logmnrg_indsubpart$", :id => false, :force => true do |t|
    t.integer "obj#",     :limit => 22, :precision => 22, :scale => 0
    t.integer "dataobj#", :limit => 22, :precision => 22, :scale => 0
    t.integer "pobj#",    :limit => 22, :precision => 22, :scale => 0
    t.integer "subpart#", :limit => 22, :precision => 22, :scale => 0
    t.integer "ts#",      :limit => 22, :precision => 22, :scale => 0, :null => false
  end

  create_table "logmnrg_lob$", :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "intcol#"
    t.decimal "col#"
    t.decimal "lobj#"
    t.decimal "chunk",   :null => false
  end

  create_table "logmnrg_lobfrag$", :id => false, :force => true do |t|
    t.decimal "fragobj#"
    t.decimal "parentobj#"
    t.decimal "tabfragobj#"
    t.decimal "indfragobj#"
    t.decimal "frag#",       :null => false
  end

  create_table "logmnrg_obj$", :id => false, :force => true do |t|
    t.integer  "objv#",       :limit => 22,  :precision => 22, :scale => 0
    t.integer  "owner#",      :limit => 22,  :precision => 22, :scale => 0
    t.string   "name",        :limit => 30
    t.integer  "namespace",   :limit => 22,  :precision => 22, :scale => 0
    t.string   "subname",     :limit => 30
    t.integer  "type#",       :limit => 22,  :precision => 22, :scale => 0
    t.raw      "oid$",        :limit => 16
    t.string   "remoteowner", :limit => 30
    t.string   "linkname",    :limit => 128
    t.integer  "flags",       :limit => 22,  :precision => 22, :scale => 0
    t.integer  "spare3",      :limit => 22,  :precision => 22, :scale => 0
    t.datetime "stime"
    t.integer  "obj#",        :limit => 22,  :precision => 22, :scale => 0, :null => false
  end

  create_table "logmnrg_seed$", :id => false, :force => true do |t|
    t.integer "seed_version",   :limit => 22, :precision => 22, :scale => 0
    t.integer "gather_version", :limit => 22, :precision => 22, :scale => 0
    t.string  "schemaname",     :limit => 30
    t.decimal "obj#"
    t.integer "objv#",          :limit => 22, :precision => 22, :scale => 0
    t.string  "table_name",     :limit => 30
    t.string  "col_name",       :limit => 30
    t.decimal "col#"
    t.decimal "intcol#"
    t.decimal "segcol#"
    t.decimal "type#"
    t.decimal "length"
    t.decimal "precision#"
    t.decimal "scale"
    t.decimal "null$",                                                       :null => false
  end

  create_table "logmnrg_tab$", :id => false, :force => true do |t|
    t.integer "ts#",        :limit => 22, :precision => 22, :scale => 0
    t.integer "cols",       :limit => 22, :precision => 22, :scale => 0
    t.integer "property",   :limit => 22, :precision => 22, :scale => 0
    t.integer "intcols",    :limit => 22, :precision => 22, :scale => 0
    t.integer "kernelcols", :limit => 22, :precision => 22, :scale => 0
    t.integer "bobj#",      :limit => 22, :precision => 22, :scale => 0
    t.integer "trigflag",   :limit => 22, :precision => 22, :scale => 0
    t.integer "flags",      :limit => 22, :precision => 22, :scale => 0
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0, :null => false
  end

  create_table "logmnrg_tabcompart$", :id => false, :force => true do |t|
    t.integer "obj#",  :limit => 22, :precision => 22, :scale => 0
    t.integer "bo#",   :limit => 22, :precision => 22, :scale => 0
    t.integer "part#", :limit => 22, :precision => 22, :scale => 0, :null => false
  end

  create_table "logmnrg_tabpart$", :id => false, :force => true do |t|
    t.integer "obj#",  :limit => 22, :precision => 22, :scale => 0
    t.integer "ts#",   :limit => 22, :precision => 22, :scale => 0
    t.decimal "part#"
    t.integer "bo#",   :limit => 22, :precision => 22, :scale => 0, :null => false
  end

  create_table "logmnrg_tabsubpart$", :id => false, :force => true do |t|
    t.integer "obj#",     :limit => 22, :precision => 22, :scale => 0
    t.integer "dataobj#", :limit => 22, :precision => 22, :scale => 0
    t.integer "pobj#",    :limit => 22, :precision => 22, :scale => 0
    t.integer "subpart#", :limit => 22, :precision => 22, :scale => 0
    t.integer "ts#",      :limit => 22, :precision => 22, :scale => 0, :null => false
  end

  create_table "logmnrg_ts$", :id => false, :force => true do |t|
    t.integer "ts#",       :limit => 22, :precision => 22, :scale => 0
    t.string  "name",      :limit => 30
    t.integer "owner#",    :limit => 22, :precision => 22, :scale => 0
    t.integer "blocksize", :limit => 22, :precision => 22, :scale => 0, :null => false
  end

  create_table "logmnrg_type$", :id => false, :force => true do |t|
    t.integer "version#",   :limit => 22, :precision => 22, :scale => 0
    t.raw     "tvoid",      :limit => 16
    t.integer "properties", :limit => 22, :precision => 22, :scale => 0
    t.integer "attributes", :limit => 22, :precision => 22, :scale => 0
    t.raw     "toid",       :limit => 16,                                :null => false
  end

  create_table "logmnrg_user$", :id => false, :force => true do |t|
    t.integer "user#", :limit => 22, :precision => 22, :scale => 0
    t.string  "name",  :limit => 30,                                :null => false
  end

  create_table "logmnrt_attrcol$", :temporary => true, :id => false, :force => true do |t|
    t.decimal "intcol#"
    t.string  "name",       :limit => 4000
    t.decimal "obj#",                                                      :null => false
    t.integer "logmnr_uid", :limit => 22,   :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22,   :precision => 22, :scale => 0
  end

  create_table "logmnrt_attribute$", :temporary => true, :id => false, :force => true do |t|
    t.integer "version#",      :limit => 22, :precision => 22, :scale => 0
    t.string  "name",          :limit => 30
    t.integer "attribute#",    :limit => 22, :precision => 22, :scale => 0
    t.raw     "attr_toid",     :limit => 16
    t.integer "attr_version#", :limit => 22, :precision => 22, :scale => 0
    t.integer "properties",    :limit => 22, :precision => 22, :scale => 0
    t.raw     "toid",          :limit => 16,                                :null => false
    t.integer "logmnr_uid",    :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",         :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_ccol$", :temporary => true, :id => false, :force => true do |t|
    t.decimal "con#"
    t.decimal "obj#"
    t.decimal "col#"
    t.decimal "pos#"
    t.decimal "intcol#",                                                 :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_cdef$", :temporary => true, :id => false, :force => true do |t|
    t.decimal "con#"
    t.decimal "cols"
    t.decimal "type#"
    t.decimal "robj#"
    t.decimal "rcon#"
    t.decimal "enabled"
    t.decimal "defer"
    t.decimal "obj#",                                                    :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_col$", :temporary => true, :id => false, :force => true do |t|
    t.integer "col#",        :limit => 22, :precision => 22, :scale => 0
    t.integer "segcol#",     :limit => 22, :precision => 22, :scale => 0
    t.string  "name",        :limit => 30
    t.integer "type#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "length",      :limit => 22, :precision => 22, :scale => 0
    t.integer "precision#",  :limit => 22, :precision => 22, :scale => 0
    t.integer "scale",       :limit => 22, :precision => 22, :scale => 0
    t.integer "null$",       :limit => 22, :precision => 22, :scale => 0
    t.integer "intcol#",     :limit => 22, :precision => 22, :scale => 0
    t.integer "property",    :limit => 22, :precision => 22, :scale => 0
    t.integer "charsetid",   :limit => 22, :precision => 22, :scale => 0
    t.integer "charsetform", :limit => 22, :precision => 22, :scale => 0
    t.integer "spare1",      :limit => 22, :precision => 22, :scale => 0
    t.integer "spare2",      :limit => 22, :precision => 22, :scale => 0
    t.integer "obj#",        :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid",  :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",       :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_coltype$", :temporary => true, :id => false, :force => true do |t|
    t.integer "col#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "intcol#",    :limit => 22, :precision => 22, :scale => 0
    t.raw     "toid",       :limit => 16
    t.integer "version#",   :limit => 22, :precision => 22, :scale => 0
    t.integer "intcols",    :limit => 22, :precision => 22, :scale => 0
    t.integer "typidcol#",  :limit => 22, :precision => 22, :scale => 0
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_dictionary$", :temporary => true, :id => false, :force => true do |t|
    t.string  "db_name",              :limit => 9
    t.integer "db_id",                :limit => 20,  :precision => 20, :scale => 0
    t.string  "db_created",           :limit => 20
    t.string  "db_dict_created",      :limit => 20
    t.integer "db_dict_scn",          :limit => 22,  :precision => 22, :scale => 0
    t.raw     "db_thread_map",        :limit => 8
    t.integer "db_txn_scnbas",        :limit => 22,  :precision => 22, :scale => 0
    t.integer "db_txn_scnwrp",        :limit => 22,  :precision => 22, :scale => 0
    t.integer "db_resetlogs_change#", :limit => 22,  :precision => 22, :scale => 0
    t.string  "db_resetlogs_time",    :limit => 20
    t.string  "db_version_time",      :limit => 20
    t.string  "db_redo_type_id",      :limit => 8
    t.string  "db_redo_release",      :limit => 60
    t.string  "db_character_set",     :limit => 30
    t.string  "db_version",           :limit => 64
    t.string  "db_status",            :limit => 64
    t.string  "db_global_name",       :limit => 128
    t.integer "db_dict_maxobjects",   :limit => 22,  :precision => 22, :scale => 0
    t.integer "db_dict_objectcount",  :limit => 22,  :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid",           :limit => 22,  :precision => 22, :scale => 0
  end

  create_table "logmnrt_icol$", :temporary => true, :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "bo#"
    t.decimal "col#"
    t.decimal "pos#"
    t.decimal "segcol#"
    t.decimal "intcol#",                                                 :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_ind$", :temporary => true, :id => false, :force => true do |t|
    t.integer "bo#",        :limit => 22, :precision => 22, :scale => 0
    t.integer "cols",       :limit => 22, :precision => 22, :scale => 0
    t.integer "type#",      :limit => 22, :precision => 22, :scale => 0
    t.decimal "flags"
    t.decimal "property"
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_indcompart$", :temporary => true, :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "dataobj#"
    t.decimal "bo#"
    t.decimal "part#",                                                   :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_indpart$", :temporary => true, :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "bo#"
    t.decimal "part#"
    t.decimal "ts#",                                                     :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_indsubpart$", :temporary => true, :id => false, :force => true do |t|
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "dataobj#",   :limit => 22, :precision => 22, :scale => 0
    t.integer "pobj#",      :limit => 22, :precision => 22, :scale => 0
    t.integer "subpart#",   :limit => 22, :precision => 22, :scale => 0
    t.integer "ts#",        :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_lob$", :temporary => true, :id => false, :force => true do |t|
    t.decimal "obj#"
    t.decimal "intcol#"
    t.decimal "col#"
    t.decimal "lobj#"
    t.decimal "chunk",                                                   :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_lobfrag$", :temporary => true, :id => false, :force => true do |t|
    t.decimal "fragobj#"
    t.decimal "parentobj#"
    t.decimal "tabfragobj#"
    t.decimal "indfragobj#"
    t.decimal "frag#",                                                    :null => false
    t.integer "logmnr_uid",  :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",       :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_obj$", :temporary => true, :id => false, :force => true do |t|
    t.integer  "objv#",        :limit => 22,  :precision => 22, :scale => 0
    t.integer  "owner#",       :limit => 22,  :precision => 22, :scale => 0
    t.string   "name",         :limit => 30
    t.integer  "namespace",    :limit => 22,  :precision => 22, :scale => 0
    t.string   "subname",      :limit => 30
    t.integer  "type#",        :limit => 22,  :precision => 22, :scale => 0
    t.raw      "oid$",         :limit => 16
    t.string   "remoteowner",  :limit => 30
    t.string   "linkname",     :limit => 128
    t.integer  "flags",        :limit => 22,  :precision => 22, :scale => 0
    t.integer  "spare3",       :limit => 22,  :precision => 22, :scale => 0
    t.datetime "stime"
    t.integer  "obj#",         :limit => 22,  :precision => 22, :scale => 0, :null => false
    t.integer  "logmnr_uid",   :limit => 22,  :precision => 22, :scale => 0
    t.decimal  "start_scnbas"
    t.decimal  "start_scnwrp"
  end

  create_table "logmnrt_seed$", :temporary => true, :id => false, :force => true do |t|
    t.integer "seed_version",   :limit => 22, :precision => 22, :scale => 0
    t.integer "gather_version", :limit => 22, :precision => 22, :scale => 0
    t.string  "schemaname",     :limit => 30
    t.decimal "obj#"
    t.integer "objv#",          :limit => 22, :precision => 22, :scale => 0
    t.string  "table_name",     :limit => 30
    t.string  "col_name",       :limit => 30
    t.decimal "col#"
    t.decimal "intcol#"
    t.decimal "segcol#"
    t.decimal "type#"
    t.decimal "length"
    t.decimal "precision#"
    t.decimal "scale"
    t.decimal "null$",                                                       :null => false
  end

  create_table "logmnrt_tab$", :temporary => true, :id => false, :force => true do |t|
    t.integer "ts#",        :limit => 22, :precision => 22, :scale => 0
    t.integer "cols",       :limit => 22, :precision => 22, :scale => 0
    t.integer "property",   :limit => 22, :precision => 22, :scale => 0
    t.integer "intcols",    :limit => 22, :precision => 22, :scale => 0
    t.integer "kernelcols", :limit => 22, :precision => 22, :scale => 0
    t.integer "bobj#",      :limit => 22, :precision => 22, :scale => 0
    t.integer "trigflag",   :limit => 22, :precision => 22, :scale => 0
    t.integer "flags",      :limit => 22, :precision => 22, :scale => 0
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_tabcompart$", :temporary => true, :id => false, :force => true do |t|
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "bo#",        :limit => 22, :precision => 22, :scale => 0
    t.integer "part#",      :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_tabpart$", :temporary => true, :id => false, :force => true do |t|
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "ts#",        :limit => 22, :precision => 22, :scale => 0
    t.decimal "part#"
    t.integer "bo#",        :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_tabsubpart$", :temporary => true, :id => false, :force => true do |t|
    t.integer "obj#",       :limit => 22, :precision => 22, :scale => 0
    t.integer "dataobj#",   :limit => 22, :precision => 22, :scale => 0
    t.integer "pobj#",      :limit => 22, :precision => 22, :scale => 0
    t.integer "subpart#",   :limit => 22, :precision => 22, :scale => 0
    t.integer "ts#",        :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_ts$", :temporary => true, :id => false, :force => true do |t|
    t.integer "ts#",        :limit => 22, :precision => 22, :scale => 0
    t.string  "name",       :limit => 30
    t.integer "owner#",     :limit => 22, :precision => 22, :scale => 0
    t.integer "blocksize",  :limit => 22, :precision => 22, :scale => 0, :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_type$", :temporary => true, :id => false, :force => true do |t|
    t.integer "version#",   :limit => 22, :precision => 22, :scale => 0
    t.raw     "tvoid",      :limit => 16
    t.integer "properties", :limit => 22, :precision => 22, :scale => 0
    t.integer "attributes", :limit => 22, :precision => 22, :scale => 0
    t.raw     "toid",       :limit => 16,                                :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
    t.integer "objv#",      :limit => 22, :precision => 22, :scale => 0
  end

  create_table "logmnrt_user$", :temporary => true, :id => false, :force => true do |t|
    t.integer "user#",      :limit => 22, :precision => 22, :scale => 0
    t.string  "name",       :limit => 30,                                :null => false
    t.integer "logmnr_uid", :limit => 22, :precision => 22, :scale => 0
  end

  create_table "map_complist$", :id => false, :force => true do |t|
    t.decimal "elem_idx"
    t.decimal "num_comp"
    t.string  "comp1_name", :limit => 30
    t.string  "comp1_val",  :limit => 2000
    t.string  "comp2_name", :limit => 30
    t.string  "comp2_val",  :limit => 2000
    t.string  "comp3_name", :limit => 30
    t.string  "comp3_val",  :limit => 2000
    t.string  "comp4_name", :limit => 30
    t.string  "comp4_val",  :limit => 2000
    t.string  "comp5_name", :limit => 30
    t.string  "comp5_val",  :limit => 2000
  end

  create_table "map_element$", :id => false, :force => true do |t|
    t.string  "elem_name",     :limit => 2000
    t.string  "elem_cfgid",    :limit => 2000
    t.decimal "elem_type"
    t.decimal "elem_idx"
    t.decimal "elem_size"
    t.decimal "elem_nsubelem"
    t.string  "elem_descr",    :limit => 2000
    t.decimal "stripe_size"
    t.decimal "elem_flags"
  end

  create_table "map_extelement$", :id => false, :force => true do |t|
    t.decimal "elem_idx"
    t.decimal "num_attrb"
    t.string  "attrb1_name", :limit => 30
    t.string  "attrb1_val",  :limit => 30
    t.string  "attrb2_name", :limit => 30
    t.string  "attrb2_val",  :limit => 30
    t.string  "attrb3_name", :limit => 30
    t.string  "attrb3_val",  :limit => 30
    t.string  "attrb4_name", :limit => 30
    t.string  "attrb4_val",  :limit => 30
    t.string  "attrb5_name", :limit => 30
    t.string  "attrb5_val",  :limit => 30
  end

  create_table "map_file$", :id => false, :force => true do |t|
    t.decimal "file_idx"
    t.string  "file_cfgid",  :limit => 2000
    t.decimal "file_status"
    t.string  "file_name",   :limit => 2000
    t.decimal "file_struct"
    t.decimal "file_type"
    t.decimal "file_size"
    t.decimal "file_nexts"
  end

  create_table "map_file_extent$", :id => false, :force => true do |t|
    t.decimal "file_idx"
    t.decimal "ext_num"
    t.decimal "ext_dev_off"
    t.decimal "ext_size"
    t.decimal "ext_file_off"
    t.decimal "ext_type"
    t.string  "elem_name",    :limit => 2000
    t.decimal "elem_idx"
  end

  create_table "map_object", :temporary => true, :id => false, :force => true do |t|
    t.string  "object_name",   :limit => 2000
    t.string  "object_owner",  :limit => 2000
    t.string  "object_type",   :limit => 2000
    t.decimal "file_map_idx"
    t.decimal "depth"
    t.decimal "elem_idx"
    t.decimal "cu_size"
    t.decimal "stride"
    t.decimal "num_cu"
    t.decimal "elem_offset"
    t.decimal "file_offset"
    t.string  "data_type",     :limit => 2000
    t.decimal "parity_pos"
    t.decimal "parity_period"
  end

  create_table "map_subelement$", :id => false, :force => true do |t|
    t.decimal "sub_num"
    t.decimal "sub_size"
    t.decimal "elem_offset"
    t.decimal "sub_flags"
    t.decimal "parent_idx"
    t.decimal "child_idx"
    t.string  "elem_name",   :limit => 2000
  end

  create_table "metafilter$", :id => false, :force => true do |t|
    t.string  "filter",      :limit => 30,   :null => false
    t.string  "type",        :limit => 30,   :null => false
    t.string  "model",       :limit => 30,   :null => false
    t.decimal "properties",                  :null => false
    t.decimal "view_attr",                   :null => false
    t.string  "attrname",    :limit => 2000
    t.decimal "default_val"
  end

  add_index "metafilter$", ["filter", "type", "model"], :name => "i_metafilter$", :unique => true

  create_table "metanametrans$", :id => false, :force => true do |t|
    t.string  "name",       :limit => 200,  :null => false
    t.string  "htype",      :limit => 30,   :null => false
    t.string  "ptype",      :limit => 30,   :null => false
    t.decimal "seq#",                       :null => false
    t.decimal "properties",                 :null => false
    t.string  "model",      :limit => 30,   :null => false
    t.string  "descrip",    :limit => 2000
  end

  add_index "metanametrans$", ["model", "htype", "name"], :name => "i_metanametrans1$"
  add_index "metanametrans$", ["model", "ptype", "seq#"], :name => "i_metanametrans2$"

  create_table "metapathmap$", :id => false, :force => true do |t|
    t.string  "name",    :limit => 200, :null => false
    t.string  "htype",   :limit => 30,  :null => false
    t.string  "model",   :limit => 30,  :null => false
    t.decimal "version",                :null => false
  end

  add_index "metapathmap$", ["name", "htype", "model"], :name => "i_metapathmap$"

  create_table "metascript$", :id => false, :force => true do |t|
    t.string  "htype",      :limit => 30, :null => false
    t.string  "ptype",      :limit => 30, :null => false
    t.decimal "seq#",                     :null => false
    t.decimal "rseq#",                    :null => false
    t.string  "ltype",      :limit => 30, :null => false
    t.decimal "properties",               :null => false
    t.string  "model",      :limit => 30, :null => false
    t.decimal "version",                  :null => false
  end

  add_index "metascript$", ["model", "htype", "seq#", "version"], :name => "i_metascript2$", :unique => true
  add_index "metascript$", ["ptype", "seq#", "model", "version"], :name => "i_metascript1$", :unique => true

  create_table "metascriptfilter$", :id => false, :force => true do |t|
    t.string  "htype",      :limit => 30,                    :null => false
    t.string  "ptype",      :limit => 30,                    :null => false
    t.decimal "seq#",                                        :null => false
    t.string  "ltype",      :limit => 30,                    :null => false
    t.string  "filter",     :limit => 30,                    :null => false
    t.string  "pfilter",    :limit => 30
    t.string  "vcval",      :limit => 2000
    t.decimal "bval"
    t.decimal "nval"
    t.decimal "properties",                 :default => 0.0, :null => false
    t.string  "model",      :limit => 30,                    :null => false
  end

  add_index "metascriptfilter$", ["model", "htype", "seq#"], :name => "i_metascriptfilter1$"
  add_index "metascriptfilter$", ["model", "ptype", "seq#"], :name => "i_metascriptfilter2$"

  create_table "metastylesheet", :id => false, :force => true do |t|
    t.string "name",       :limit => 30, :null => false
    t.string "model",      :limit => 30, :null => false
    t.text   "stylesheet"
  end

  create_table "metaview$", :id => false, :force => true do |t|
    t.string  "type",       :limit => 30, :null => false
    t.decimal "flags",                    :null => false
    t.decimal "properties",               :null => false
    t.string  "model",      :limit => 30, :null => false
    t.decimal "version",                  :null => false
    t.string  "xmltag",     :limit => 30
    t.string  "udt",        :limit => 30
    t.string  "schema",     :limit => 30
    t.string  "viewname",   :limit => 30
  end

  add_index "metaview$", ["type", "model", "version", "flags"], :name => "i_metaview$", :unique => true

  create_table "metaxsl$", :id => false, :force => true do |t|
    t.string "xmltag",    :limit => 30,   :null => false
    t.string "transform", :limit => 30,   :null => false
    t.string "model",     :limit => 30,   :null => false
    t.string "script",    :limit => 2000, :null => false
  end

  create_table "metaxslparam$", :id => false, :force => true do |t|
    t.string  "model",       :limit => 30,                    :null => false
    t.string  "transform",   :limit => 30,                    :null => false
    t.string  "type",        :limit => 30,                    :null => false
    t.string  "param",       :limit => 30,                    :null => false
    t.string  "default_val", :limit => 2000
    t.decimal "properties",                  :default => 0.0, :null => false
    t.string  "parse_attr",  :limit => 2000
  end

  add_index "metaxslparam$", ["model", "transform", "type", "param"], :name => "i_metaxslparam$", :unique => true

  create_table "method$", :id => false, :force => true do |t|
    t.raw     "toid",          :limit => 16,   :null => false
    t.decimal "version#",                      :null => false
    t.decimal "method#",                       :null => false
    t.string  "name",          :limit => 30,   :null => false
    t.decimal "properties",                    :null => false
    t.decimal "parameters#",                   :null => false
    t.decimal "results",                       :null => false
    t.decimal "xflags"
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
    t.string  "externvarname", :limit => 4000
  end

  add_index "method$", ["toid", "version#", "method#"], :name => "i_method1", :unique => true

  create_table "migrate$", :id => false, :force => true do |t|
    t.string   "version#", :limit => 30
    t.datetime "migdate"
    t.decimal  "migrated",               :null => false
  end

  create_table "mlog$", :id => false, :force => true do |t|
    t.string   "mowner",     :limit => 30, :null => false
    t.string   "master",     :limit => 30, :null => false
    t.datetime "oldest"
    t.datetime "oldest_pk"
    t.datetime "oldest_seq"
    t.decimal  "oscn"
    t.datetime "youngest"
    t.decimal  "yscn"
    t.string   "log",        :limit => 30, :null => false
    t.string   "trig",       :limit => 30
    t.decimal  "flag"
    t.datetime "mtime",                    :null => false
    t.string   "temp_log",   :limit => 30
    t.datetime "oldest_oid"
    t.datetime "oldest_new"
  end

  create_table "mlog_refcol$", :id => false, :force => true do |t|
    t.string   "mowner",  :limit => 30,                                :null => false
    t.string   "master",  :limit => 30,                                :null => false
    t.string   "colname", :limit => 30,                                :null => false
    t.datetime "oldest"
    t.integer  "flag",                  :precision => 38, :scale => 0
  end

  add_index "mlog_refcol$", ["mowner", "master", "colname"], :name => "i_mlog_refcol1", :unique => true

  create_table "mon_mods$", :id => false, :force => true do |t|
    t.decimal  "obj#"
    t.decimal  "inserts"
    t.decimal  "updates"
    t.decimal  "deletes"
    t.datetime "timestamp"
    t.decimal  "flags"
    t.decimal  "drop_segments"
  end

  add_index "mon_mods$", ["obj#"], :name => "i_mon_mods$_obj", :unique => true

  create_table "mon_mods_all$", :id => false, :force => true do |t|
    t.decimal  "obj#"
    t.decimal  "inserts"
    t.decimal  "updates"
    t.decimal  "deletes"
    t.datetime "timestamp"
    t.decimal  "flags"
    t.decimal  "drop_segments"
  end

  add_index "mon_mods_all$", ["obj#"], :name => "i_mon_mods_all$_obj", :unique => true

  create_table "ncomp_dll$", :id => false, :force => true do |t|
    t.decimal "obj#",                    :null => false
    t.decimal "version"
    t.binary  "dll"
    t.raw     "dllname", :limit => 1024
  end

  add_index "ncomp_dll$", ["obj#", "version"], :name => "i_ncomp_dll1", :unique => true

  create_table "noexp$", :id => false, :force => true do |t|
    t.string  "owner",    :limit => 30, :null => false
    t.string  "name",     :limit => 30, :null => false
    t.decimal "obj_type",               :null => false
  end

  create_table "ntab$", :id => false, :force => true do |t|
    t.decimal "obj#",                                       :null => false
    t.decimal "col#",                                       :null => false
    t.decimal "intcol#",                                    :null => false
    t.decimal "ntab#",                                      :null => false
    t.string  "name",    :limit => 4000, :default => "NT$", :null => false
  end

  add_index "ntab$", ["ntab#"], :name => "i_ntab3"
  add_index "ntab$", ["obj#", "col#"], :name => "i_ntab1"
  add_index "ntab$", ["obj#", "intcol#"], :name => "i_ntab2", :unique => true

  create_table "obj$", :id => false, :force => true do |t|
    t.decimal  "obj#",                        :null => false
    t.decimal  "dataobj#"
    t.decimal  "owner#",                      :null => false
    t.string   "name",        :limit => 30,   :null => false
    t.decimal  "namespace",                   :null => false
    t.string   "subname",     :limit => 30
    t.decimal  "type#",                       :null => false
    t.datetime "ctime",                       :null => false
    t.datetime "mtime",                       :null => false
    t.datetime "stime",                       :null => false
    t.decimal  "status",                      :null => false
    t.string   "remoteowner", :limit => 30
    t.string   "linkname",    :limit => 128
    t.decimal  "flags"
    t.raw      "oid$",        :limit => 16
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",      :limit => 1000
    t.string   "spare5",      :limit => 1000
    t.datetime "spare6"
  end

  add_index "obj$", ["obj#"], :name => "i_obj1", :unique => true
  add_index "obj$", ["oid$"], :name => "i_obj3"
  add_index "obj$", ["owner#", "name", "namespace", "remoteowner", "linkname", "subname"], :name => "i_obj2", :unique => true

# Could not dump table "objauth$" because of following StandardError
#   Unknown type 'ROWID' for column 'parent'

  create_table "object_usage", :id => false, :force => true do |t|
    t.decimal "obj#",                           :null => false
    t.decimal "flags",                          :null => false
    t.string  "start_monitoring", :limit => 19
    t.string  "end_monitoring",   :limit => 19
  end

  add_index "object_usage", ["obj#"], :name => "i_stats_obj#"

  create_table "objpriv$", :id => false, :force => true do |t|
    t.decimal "obj#",       :null => false
    t.decimal "privilege#", :null => false
  end

  create_table "odci_secobj$", :temporary => true, :id => false, :force => true do |t|
    t.string "idxschema",    :limit => 30
    t.string "idxname",      :limit => 30
    t.string "secobjschema", :limit => 30
    t.string "secobjname",   :limit => 30
  end

  create_table "odci_warnings$", :temporary => true, :id => false, :force => true do |t|
    t.decimal "c1"
    t.string  "c2", :limit => 2000
  end

  create_table "oid$", :id => false, :force => true do |t|
    t.decimal "user#",               :null => false
    t.raw     "oid$",  :limit => 16, :null => false
    t.decimal "obj#",                :null => false
  end

  add_index "oid$", ["user#", "oid$"], :name => "i_oid1", :unique => true

  create_table "opancillary$", :id => false, :force => true do |t|
    t.decimal "obj#",      :null => false
    t.decimal "bind#",     :null => false
    t.decimal "primop#",   :null => false
    t.decimal "primbind#", :null => false
  end

  add_index "opancillary$", ["obj#", "bind#"], :name => "opanc1"

  create_table "oparg$", :id => false, :force => true do |t|
    t.decimal "obj#",                   :null => false
    t.decimal "bind#",                  :null => false
    t.decimal "position",               :null => false
    t.string  "type",     :limit => 61
  end

  add_index "oparg$", ["obj#"], :name => "oparg1"

  create_table "opbinding$", :id => false, :force => true do |t|
    t.decimal "obj#",                       :null => false
    t.decimal "bind#",                      :null => false
    t.string  "functionname", :limit => 92
    t.string  "returnschema", :limit => 30
    t.string  "returntype",   :limit => 30
    t.string  "impschema",    :limit => 30
    t.string  "imptype",      :limit => 30
    t.decimal "property",                   :null => false
    t.string  "spare1",       :limit => 30
    t.string  "spare2",       :limit => 30
    t.decimal "spare3"
  end

  add_index "opbinding$", ["obj#", "bind#"], :name => "opbind1", :unique => true

  create_table "operator$", :id => false, :force => true do |t|
    t.decimal "obj#",        :null => false
    t.decimal "numbind",     :null => false
    t.decimal "nextbindnum", :null => false
    t.decimal "property",    :null => false
  end

  add_index "operator$", ["obj#"], :name => "oper1", :unique => true

  create_table "opqtype$", :id => false, :force => true do |t|
    t.decimal "obj#",                      :null => false
    t.decimal "intcol#",                   :null => false
    t.decimal "type"
    t.decimal "flags"
    t.decimal "lobcol"
    t.decimal "objcol"
    t.decimal "extracol"
    t.raw     "schemaoid", :limit => 16
    t.decimal "elemnum"
    t.string  "schemaurl", :limit => 4000
  end

  add_index "opqtype$", ["obj#", "intcol#"], :name => "i_opqtype1", :unique => true

  create_table "optstat_hist_control$", :id => false, :force => true do |t|
    t.string    "sname",  :limit => 30
    t.decimal   "sval1"
    t.timestamp "sval2",  :limit => 6
    t.decimal   "spare1"
    t.decimal   "spare2"
    t.decimal   "spare3"
    t.string    "spare4", :limit => 1000
    t.string    "spare5", :limit => 1000
    t.timestamp "spare6", :limit => 6
  end

  create_table "parameter$", :id => false, :force => true do |t|
    t.raw     "toid",           :limit => 16,   :null => false
    t.decimal "version#",                       :null => false
    t.decimal "method#",                        :null => false
    t.string  "name",           :limit => 30,   :null => false
    t.decimal "parameter#",                     :null => false
    t.raw     "param_toid",     :limit => 16,   :null => false
    t.decimal "param_version#",                 :null => false
    t.decimal "synobj#"
    t.decimal "properties",                     :null => false
    t.decimal "charsetid"
    t.decimal "charsetform"
    t.string  "default$",       :limit => 4000
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
  end

  add_index "parameter$", ["toid", "version#", "method#", "name"], :name => "i_parameter1", :unique => true
  add_index "parameter$", ["toid", "version#", "method#", "parameter#"], :name => "i_parameter2", :unique => true

  create_table "partcol$", :id => false, :force => true do |t|
    t.decimal "obj#",        :null => false
    t.decimal "intcol#",     :null => false
    t.decimal "col#",        :null => false
    t.decimal "pos#",        :null => false
    t.decimal "spare1"
    t.decimal "segcol#",     :null => false
    t.decimal "type#",       :null => false
    t.decimal "charsetform"
  end

  add_index "partcol$", ["obj#"], :name => "i_partcol$"

  create_table "partlob$", :id => false, :force => true do |t|
    t.decimal "lobj#",      :null => false
    t.decimal "tabobj#",    :null => false
    t.decimal "intcol#",    :null => false
    t.decimal "defts#"
    t.decimal "defchunk",   :null => false
    t.decimal "defpctver$", :null => false
    t.decimal "defflags",   :null => false
    t.decimal "defpro",     :null => false
    t.decimal "definiexts"
    t.decimal "defextsize"
    t.decimal "defminexts"
    t.decimal "defmaxexts"
    t.decimal "defextpct"
    t.decimal "deflists"
    t.decimal "defgroups"
    t.decimal "defbufpool"
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
  end

  create_table "partobj$", :id => false, :force => true do |t|
    t.decimal "obj#",                        :null => false
    t.decimal "parttype",                    :null => false
    t.decimal "partcnt",                     :null => false
    t.decimal "partkeycols",                 :null => false
    t.decimal "flags"
    t.decimal "defts#"
    t.decimal "defpctfree",                  :null => false
    t.decimal "defpctused",                  :null => false
    t.decimal "defpctthres"
    t.decimal "definitrans",                 :null => false
    t.decimal "defmaxtrans",                 :null => false
    t.decimal "deftiniexts"
    t.decimal "defextsize"
    t.decimal "defminexts"
    t.decimal "defmaxexts"
    t.decimal "defextpct"
    t.decimal "deflists",                    :null => false
    t.decimal "defgroups",                   :null => false
    t.decimal "deflogging",                  :null => false
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
    t.decimal "definclcol"
    t.string  "parameters",  :limit => 1000
  end

  add_index "partobj$", ["obj#"], :name => "i_partobj$", :unique => true

  create_table "pending_sessions$", :id => false, :force => true do |t|
    t.string  "local_tran_id", :limit => 22,                                 :null => false
    t.integer "session_id",                   :precision => 38, :scale => 0, :null => false
    t.raw     "branch_id",     :limit => 64,                                 :null => false
    t.string  "interface",     :limit => 1,                                  :null => false
    t.decimal "type#"
    t.string  "parent_dbid",   :limit => 16
    t.string  "parent_db",     :limit => 128
    t.integer "db_userid",                    :precision => 38, :scale => 0, :null => false
  end

  create_table "pending_sub_sessions$", :id => false, :force => true do |t|
    t.string  "local_tran_id",  :limit => 22,                                 :null => false
    t.integer "session_id",                    :precision => 38, :scale => 0, :null => false
    t.integer "sub_session_id",                :precision => 38, :scale => 0, :null => false
    t.string  "interface",      :limit => 1,                                  :null => false
    t.string  "dbid",           :limit => 16,                                 :null => false
    t.integer "link_owner",                    :precision => 38, :scale => 0, :null => false
    t.string  "dblink",         :limit => 128,                                :null => false
    t.raw     "branch_id",      :limit => 64
    t.raw     "spare",          :limit => 64
  end

  create_table "pending_trans$", :id => false, :force => true do |t|
    t.string   "local_tran_id",     :limit => 22,                                 :null => false
    t.integer  "global_tran_fmt",                  :precision => 38, :scale => 0, :null => false
    t.string   "global_oracle_id",  :limit => 64
    t.raw      "global_foreign_id", :limit => 64
    t.string   "tran_comment"
    t.string   "state",             :limit => 16,                                 :null => false
    t.string   "status",            :limit => 1,                                  :null => false
    t.string   "heuristic_dflt",    :limit => 1
    t.raw      "session_vector",    :limit => 4,                                  :null => false
    t.raw      "reco_vector",       :limit => 4,                                  :null => false
    t.decimal  "type#"
    t.datetime "fail_time",                                                       :null => false
    t.datetime "heuristic_time"
    t.datetime "reco_time",                                                       :null => false
    t.string   "top_db_user",       :limit => 30
    t.string   "top_os_user",       :limit => 64
    t.string   "top_os_host",       :limit => 128
    t.string   "top_os_terminal"
    t.string   "global_commit#",    :limit => 16
    t.decimal  "spare1"
    t.string   "spare2",            :limit => 30
    t.decimal  "spare3"
    t.string   "spare4",            :limit => 30
  end

  add_index "pending_trans$", ["local_tran_id"], :name => "i_pending_trans1", :unique => true

# Could not dump table "plan_table$" because of following StandardError
#   Unknown type 'LONG' for column 'other'

  create_table "procedure$", :id => false, :force => true do |t|
    t.decimal "obj#",                      :null => false
    t.string  "audit$",      :limit => 38, :null => false
    t.decimal "storagesize"
    t.decimal "options"
  end

  add_index "procedure$", ["obj#"], :name => "i_procedure1", :unique => true

  create_table "procedurec$", :id => false, :force => true do |t|
    t.decimal "obj#",        :null => false
    t.decimal "procedure#",  :null => false
    t.decimal "entrypoint#", :null => false
  end

  add_index "procedurec$", ["obj#", "procedure#"], :name => "i_procedurec$", :unique => true

  create_table "procedureinfo$", :id => false, :force => true do |t|
    t.decimal "obj#",                        :null => false
    t.decimal "procedure#",                  :null => false
    t.decimal "overload#",                   :null => false
    t.string  "procedurename", :limit => 30
    t.decimal "properties",                  :null => false
    t.decimal "itypeobj#"
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
    t.decimal "spare4"
  end

  add_index "procedureinfo$", ["obj#", "procedurename", "overload#"], :name => "i_procedureinfo1", :unique => true

# Could not dump table "procedurejava$" because of following StandardError
#   Unknown type 'LONG' for column 'signature'

  create_table "procedureplsql$", :id => false, :force => true do |t|
    t.decimal "obj#",        :null => false
    t.decimal "procedure#",  :null => false
    t.decimal "entrypoint#", :null => false
  end

  add_index "procedureplsql$", ["obj#", "procedure#"], :name => "i_procedureplsql$", :unique => true

  create_table "profile$", :id => false, :force => true do |t|
    t.decimal "profile#",  :null => false
    t.decimal "resource#", :null => false
    t.decimal "type#",     :null => false
    t.decimal "limit#",    :null => false
  end

  add_index "profile$", ["profile#"], :name => "i_profile"

  create_table "profname$", :id => false, :force => true do |t|
    t.decimal "profile#",               :null => false
    t.string  "name",     :limit => 30, :null => false
  end

  add_index "profname$", ["name"], :name => "i_profname", :unique => true

  create_table "props$", :id => false, :force => true do |t|
    t.string "name",     :limit => 30,   :null => false
    t.string "value$",   :limit => 4000
    t.string "comment$", :limit => 4000
  end

  create_table "proxy_data$", :id => false, :force => true do |t|
    t.decimal "client#",             :null => false
    t.decimal "proxy#",              :null => false
    t.decimal "credential_type#",    :null => false
    t.decimal "credential_version#", :null => false
    t.decimal "credential_minor#",   :null => false
    t.decimal "flags",               :null => false
  end

  add_index "proxy_data$", ["client#", "proxy#"], :name => "i_proxy_data$", :unique => true

  create_table "proxy_info$", :id => false, :force => true do |t|
    t.decimal "client#",          :null => false
    t.decimal "proxy#",           :null => false
    t.decimal "credential_type#", :null => false
    t.decimal "flags",            :null => false
  end

  add_index "proxy_info$", ["client#", "proxy#"], :name => "i_proxy_info$", :unique => true

  create_table "proxy_role_data$", :id => false, :force => true do |t|
    t.decimal "client#", :null => false
    t.decimal "proxy#",  :null => false
    t.decimal "role#",   :null => false
  end

  add_index "proxy_role_data$", ["client#", "proxy#", "role#"], :name => "i_proxy_role_data$_2", :unique => true
  add_index "proxy_role_data$", ["client#", "proxy#"], :name => "i_proxy_role_data$_1"

  create_table "proxy_role_info$", :id => false, :force => true do |t|
    t.decimal "client#", :null => false
    t.decimal "proxy#",  :null => false
    t.decimal "role#",   :null => false
  end

  add_index "proxy_role_info$", ["client#", "proxy#", "role#"], :name => "i_proxy_role_info$_2", :unique => true
  add_index "proxy_role_info$", ["client#", "proxy#"], :name => "i_proxy_role_info$_1"

  create_table "ps$", :id => false, :force => true do |t|
    t.decimal "awseq#",                                                  :null => false
    t.integer "psnumber",  :limit => 10,  :precision => 10, :scale => 0
    t.integer "psgen",     :limit => 10,  :precision => 10, :scale => 0
    t.decimal "mapoffset"
    t.decimal "maxpages"
    t.raw     "almap",     :limit => 8
    t.raw     "header",    :limit => 200
    t.binary  "gelob"
    t.decimal "gelrec"
    t.decimal "maprec"
  end

  add_index "ps$", ["awseq#", "psnumber", "psgen"], :name => "i_ps$", :unique => true

  create_table "pstubtbl", :temporary => true, :id => false, :force => true do |t|
    t.string  "username", :limit => 30
    t.string  "dbname",   :limit => 128
    t.string  "lun",      :limit => 30
    t.string  "lutype",   :limit => 3
    t.decimal "lineno"
    t.string  "line",     :limit => 1800
  end

  create_table "publisher", :id => false, :force => true do |t|
    t.string "name", :limit => 20
  end

  create_table "rec_tab$", :id => false, :force => true do |t|
    t.decimal "ec_obj#",                   :null => false
    t.string  "tab_alias", :limit => 30
    t.string  "tab_name",  :limit => 4000
    t.decimal "property"
    t.decimal "tab_id"
    t.decimal "tab_obj#"
  end

  add_index "rec_tab$", ["ec_obj#", "tab_id"], :name => "i_rec_tab"

  create_table "rec_var$", :id => false, :force => true do |t|
    t.decimal "ec_obj#",                       :null => false
    t.string  "var_name",      :limit => 30
    t.string  "var_type",      :limit => 4000
    t.string  "var_val_func",  :limit => 4000
    t.string  "var_mthd_func", :limit => 228
    t.decimal "property"
    t.decimal "var_id"
    t.decimal "var_dty"
    t.decimal "precision#"
    t.decimal "scale"
    t.decimal "maxlen"
    t.decimal "charsetid"
    t.decimal "charsetform"
    t.raw     "toid",          :limit => 16
    t.decimal "version"
    t.decimal "num_attrs"
  end

  add_index "rec_var$", ["ec_obj#", "var_id"], :name => "i_rec_var"

  create_table "recent_resource_incarnations$", :id => false, :force => true do |t|
    t.string    "resource_type",  :limit => 30,   :null => false
    t.decimal   "resource_id"
    t.string    "resource_name",  :limit => 256
    t.string    "db_unique_name", :limit => 30,   :null => false
    t.string    "db_domain",      :limit => 128,  :null => false
    t.string    "instance_name",  :limit => 30,   :null => false
    t.string    "host_name",      :limit => 512
    t.string    "location",       :limit => 512
    t.string    "incarnation",    :limit => 30,   :null => false
    t.timestamp "startup_time",   :limit => 9,    :null => false
    t.timestamp "shutdown_time",  :limit => 9
    t.string    "description",    :limit => 4000
  end

  create_table "reco_script$", :id => false, :force => true do |t|
    t.raw      "oid",                    :limit => 16
    t.string   "invoking_package_owner", :limit => 30
    t.string   "invoking_package",       :limit => 30
    t.string   "invoking_procedure",     :limit => 30
    t.string   "invoking_user",          :limit => 30
    t.decimal  "total_blocks"
    t.text     "context"
    t.decimal  "status"
    t.decimal  "done_block_num"
    t.string   "script_comment",         :limit => 4000
    t.datetime "ctime"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",                 :limit => 1000
    t.string   "spare5",                 :limit => 1000
    t.datetime "spare6"
  end

  add_index "reco_script$", ["oid"], :name => "reco_script$_unq", :unique => true, :tablespace => "sysaux"

  create_table "reco_script_block$", :id => false, :force => true do |t|
    t.raw      "oid",                  :limit => 16
    t.decimal  "block_num"
    t.text     "forward_block"
    t.string   "forward_block_dblink", :limit => 128
    t.text     "undo_block"
    t.string   "undo_block_dblink",    :limit => 128
    t.text     "state_block"
    t.decimal  "status"
    t.text     "context"
    t.string   "block_comment",        :limit => 4000
    t.datetime "ctime"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",               :limit => 1000
    t.string   "spare5",               :limit => 1000
    t.datetime "spare6"
  end

  add_index "reco_script_block$", ["oid", "block_num"], :name => "reco_script_block$_unq", :unique => true, :tablespace => "sysaux"

  create_table "reco_script_error$", :id => false, :force => true do |t|
    t.raw      "oid",                 :limit => 16
    t.decimal  "block_num"
    t.decimal  "error_number"
    t.string   "error_message",       :limit => 4000
    t.datetime "error_creation_time"
    t.decimal  "spare1"
    t.string   "spare2",              :limit => 1000
  end

  create_table "reco_script_params$", :id => false, :force => true do |t|
    t.raw     "oid",         :limit => 16
    t.decimal "param_index"
    t.string  "name",        :limit => 30
    t.string  "value",       :limit => 4000
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3",      :limit => 1000
  end

  add_index "reco_script_params$", ["oid", "name", "param_index"], :name => "reco_script_params$_unq", :unique => true, :tablespace => "sysaux"

  create_table "recyclebin$", :id => false, :force => true do |t|
    t.decimal  "obj#",                         :null => false
    t.decimal  "owner#",                       :null => false
    t.string   "original_name",  :limit => 32
    t.decimal  "operation",                    :null => false
    t.decimal  "type#",                        :null => false
    t.decimal  "ts#"
    t.decimal  "file#"
    t.decimal  "block#"
    t.datetime "droptime"
    t.decimal  "dropscn"
    t.string   "partition_name", :limit => 32
    t.decimal  "flags"
    t.decimal  "related",                      :null => false
    t.decimal  "bo",                           :null => false
    t.decimal  "purgeobj",                     :null => false
    t.decimal  "base_ts#"
    t.decimal  "base_owner#"
    t.decimal  "space"
    t.decimal  "con#"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
  end

  add_index "recyclebin$", ["obj#"], :name => "recyclebin$_obj"
  add_index "recyclebin$", ["owner#"], :name => "recyclebin$_owner"
  add_index "recyclebin$", ["ts#"], :name => "recyclebin$_ts"

  create_table "redef$", :id => false, :force => true do |t|
    t.integer "id",                  :precision => 38, :scale => 0, :null => false
    t.string  "name",  :limit => 30,                                :null => false
    t.integer "state",               :precision => 38, :scale => 0, :null => false
    t.integer "flag",                :precision => 38, :scale => 0
  end

  add_index "redef$", ["id"], :name => "ui_redef_id$", :unique => true
  add_index "redef$", ["name"], :name => "ui_redef_name$", :unique => true

  create_table "redef_dep_error$", :id => false, :force => true do |t|
    t.integer "redef_id",                :precision => 38, :scale => 0, :null => false
    t.integer "obj_type",                :precision => 38, :scale => 0, :null => false
    t.string  "obj_owner", :limit => 30,                                :null => false
    t.string  "obj_name",  :limit => 30,                                :null => false
    t.string  "bt_owner",  :limit => 30
    t.string  "bt_name",   :limit => 30
    t.text    "ddl_txt"
  end

  add_index "redef_dep_error$", ["redef_id", "obj_type", "obj_owner", "obj_name"], :name => "i_redef_dep_error$"

  create_table "redef_object$", :id => false, :force => true do |t|
    t.integer "redef_id",                    :precision => 38, :scale => 0, :null => false
    t.integer "obj_type",                    :precision => 38, :scale => 0, :null => false
    t.string  "obj_owner",     :limit => 30,                                :null => false
    t.string  "obj_name",      :limit => 30,                                :null => false
    t.string  "int_obj_owner", :limit => 30
    t.string  "int_obj_name",  :limit => 30
    t.string  "bt_owner",      :limit => 30
    t.string  "bt_name",       :limit => 30
    t.integer "genflag",                     :precision => 38, :scale => 0
    t.integer "typflag",                     :precision => 38, :scale => 0
  end

  add_index "redef_object$", ["redef_id", "obj_type", "obj_owner", "obj_name"], :name => "i_redef_object$"

  create_table "refcon$", :id => false, :force => true do |t|
    t.decimal "obj#",                   :null => false
    t.decimal "col#",                   :null => false
    t.decimal "intcol#",                :null => false
    t.decimal "reftyp",                 :null => false
    t.raw     "stabid",   :limit => 16
    t.raw     "expctoid", :limit => 16
  end

  add_index "refcon$", ["obj#", "col#"], :name => "i_refcon1"
  add_index "refcon$", ["obj#", "intcol#"], :name => "i_refcon2", :unique => true

# Could not dump table "reg$" because of following StandardError
#   Unknown type 'ANYDATA' for column 'any_context'

# Could not dump table "reg_snap$" because of following StandardError
#   Unknown type 'LONG' for column 'query_txt'

  create_table "registry$", :id => false, :force => true do |t|
    t.string   "cid",              :limit => 30, :null => false
    t.string   "cname"
    t.decimal  "schema#",                        :null => false
    t.decimal  "invoker#",                       :null => false
    t.string   "version",          :limit => 30
    t.string   "edition",          :limit => 30
    t.decimal  "status",                         :null => false
    t.decimal  "flags",                          :null => false
    t.datetime "modified"
    t.string   "pid",              :limit => 30
    t.string   "banner",           :limit => 80
    t.string   "vproc",            :limit => 61
    t.datetime "date_invalid"
    t.datetime "date_valid"
    t.datetime "date_loading"
    t.datetime "date_loaded"
    t.datetime "date_upgrading"
    t.datetime "date_upgraded"
    t.datetime "date_downgrading"
    t.datetime "date_downgraded"
    t.datetime "date_removing"
    t.datetime "date_removed"
    t.string   "namespace",        :limit => 30, :null => false
    t.string   "org_version",      :limit => 30
    t.string   "prv_version",      :limit => 30
    t.raw      "signature",        :limit => 20
  end

  create_table "registry$history", :id => false, :force => true do |t|
    t.timestamp "action_time", :limit => 6
    t.string    "action",      :limit => 30
    t.string    "namespace",   :limit => 30
    t.string    "version",     :limit => 30
    t.decimal   "id"
    t.string    "comments"
  end

  create_table "registry$log", :id => false, :force => true do |t|
    t.string    "cid",       :limit => 30
    t.string    "namespace", :limit => 30
    t.decimal   "operation",                 :null => false
    t.timestamp "optime",    :limit => 6
    t.string    "errmsg",    :limit => 1000
  end

  create_table "registry$schemas", :id => false, :force => true do |t|
    t.string  "cid",       :limit => 30, :null => false
    t.string  "namespace", :limit => 30, :null => false
    t.decimal "schema#",                 :null => false
  end

  create_table "resource_consumer_group$", :id => false, :force => true do |t|
    t.decimal "obj#",                        :null => false
    t.string  "name",        :limit => 30
    t.decimal "mandatory"
    t.string  "cpu_method",  :limit => 30
    t.string  "description", :limit => 2000
    t.string  "status",      :limit => 30
  end

  create_table "resource_cost$", :id => false, :force => true do |t|
    t.decimal "resource#", :null => false
    t.decimal "cost",      :null => false
  end

  create_table "resource_group_mapping$", :id => false, :force => true do |t|
    t.string "attribute",      :limit => 30
    t.string "value",          :limit => 128
    t.string "consumer_group", :limit => 30
    t.string "status",         :limit => 30
  end

  create_table "resource_map", :id => false, :force => true do |t|
    t.decimal "resource#",               :null => false
    t.decimal "type#",                   :null => false
    t.string  "name",      :limit => 32, :null => false
  end

  create_table "resource_mapping_priority$", :id => false, :force => true do |t|
    t.string  "attribute", :limit => 30
    t.decimal "priority"
    t.string  "status",    :limit => 30
  end

  create_table "resource_plan$", :id => false, :force => true do |t|
    t.decimal "obj#",                                :null => false
    t.string  "name",                :limit => 30
    t.decimal "mandatory"
    t.string  "cpu_method",          :limit => 30
    t.string  "mast_method",         :limit => 30
    t.string  "pdl_method",          :limit => 30
    t.decimal "num_plan_directives"
    t.string  "description",         :limit => 2000
    t.string  "status",              :limit => 30
    t.string  "que_method",          :limit => 30
  end

  create_table "resource_plan_directive$", :id => false, :force => true do |t|
    t.decimal "obj#",                                      :null => false
    t.string  "plan",                      :limit => 30
    t.string  "group_or_subplan",          :limit => 30
    t.decimal "is_subplan",                                :null => false
    t.string  "description",               :limit => 2000
    t.decimal "mandatory"
    t.decimal "cpu_p1"
    t.decimal "cpu_p2"
    t.decimal "cpu_p3"
    t.decimal "cpu_p4"
    t.decimal "cpu_p5"
    t.decimal "cpu_p6"
    t.decimal "cpu_p7"
    t.decimal "cpu_p8"
    t.decimal "max_active_sess_target_p1"
    t.decimal "parallel_degree_limit_p1"
    t.string  "status",                    :limit => 30
    t.decimal "active_sess_pool_p1"
    t.decimal "queueing_p1"
    t.string  "switch_group",              :limit => 30
    t.decimal "switch_time"
    t.decimal "switch_estimate"
    t.decimal "max_est_exec_time"
    t.decimal "undo_pool"
    t.decimal "max_idle_time"
    t.decimal "max_idle_blocker_time"
    t.decimal "switch_back"
  end

  create_table "result$", :id => false, :force => true do |t|
    t.raw     "toid",            :limit => 16, :null => false
    t.decimal "version#",                      :null => false
    t.decimal "method#",                       :null => false
    t.decimal "result#",                       :null => false
    t.raw     "result_toid",     :limit => 16, :null => false
    t.decimal "result_version#",               :null => false
    t.decimal "synobj#"
    t.decimal "properties",                    :null => false
    t.decimal "charsetid"
    t.decimal "charsetform"
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
  end

  add_index "result$", ["toid", "version#", "method#", "result#"], :name => "i_result1", :unique => true

  create_table "rgchild$", :id => false, :force => true do |t|
    t.string  "owner",    :limit => 30,                                                        :null => false
    t.string  "name",     :limit => 30,                                                        :null => false
    t.string  "type#",    :limit => 30,                                :default => "SNAPSHOT"
    t.decimal "field1",                                                :default => 0.0
    t.decimal "refgroup"
    t.integer "instsite",               :precision => 38, :scale => 0, :default => 0
  end

  add_index "rgchild$", ["owner", "name", "instsite", "type#"], :name => "i_rgchild", :unique => true

  create_table "rgroup$", :id => false, :force => true do |t|
    t.decimal "refgroup"
    t.string  "owner",            :limit => 30,                                                 :null => false
    t.string  "name",             :limit => 30,                                                 :null => false
    t.decimal "flag",                                                          :default => 0.0
    t.string  "rollback_seg",     :limit => 30
    t.decimal "field1",                                                        :default => 0.0
    t.decimal "job",                                                                            :null => false
    t.integer "purge_opt#",                     :precision => 38, :scale => 0
    t.integer "parallelism#",                   :precision => 38, :scale => 0
    t.integer "heap_size#",                     :precision => 38, :scale => 0
    t.integer "instsite",                       :precision => 38, :scale => 0, :default => 0
    t.decimal "refresh_sequence"
  end

  add_index "rgroup$", ["job"], :name => "i_rgjob"
  add_index "rgroup$", ["owner", "name", "instsite"], :name => "i_rgroup", :unique => true
  add_index "rgroup$", ["refgroup"], :name => "i_rgref", :unique => true

  create_table "rls$", :id => false, :force => true do |t|
    t.decimal "obj#",                      :null => false
    t.string  "gname",       :limit => 30, :null => false
    t.string  "pname",       :limit => 30, :null => false
    t.decimal "stmt_type",                 :null => false
    t.decimal "check_opt",                 :null => false
    t.decimal "enable_flag",               :null => false
    t.string  "pfschma",     :limit => 30, :null => false
    t.string  "ppname",      :limit => 30
    t.string  "pfname",      :limit => 30, :null => false
    t.decimal "ptype"
  end

  add_index "rls$", ["obj#", "gname", "pname"], :name => "i_rls"
  add_index "rls$", ["obj#"], :name => "i_rls2"

  create_table "rls_ctx$", :id => false, :force => true do |t|
    t.decimal "obj#",                :null => false
    t.string  "ns",    :limit => 30, :null => false
    t.string  "attr",  :limit => 30, :null => false
    t.decimal "synid"
  end

  add_index "rls_ctx$", ["obj#"], :name => "i_rls_ctx"

  create_table "rls_grp$", :id => false, :force => true do |t|
    t.decimal "obj#",                :null => false
    t.string  "gname", :limit => 30, :null => false
    t.decimal "synid"
  end

  add_index "rls_grp$", ["obj#"], :name => "i_rls_grp"

  create_table "rls_sc$", :id => false, :force => true do |t|
    t.decimal "obj#",                  :null => false
    t.string  "gname",   :limit => 30, :null => false
    t.string  "pname",   :limit => 30, :null => false
    t.decimal "intcol#"
  end

  add_index "rls_sc$", ["obj#", "gname", "pname"], :name => "i_rls_sc"

# Could not dump table "rule$" because of following StandardError
#   Unknown type 'RE$NV_LIST' for column 'r_action'

  create_table "rule_ec$", :id => false, :force => true do |t|
    t.decimal "obj#",                       :null => false
    t.string  "eval_func",  :limit => 4000
    t.decimal "property"
    t.string  "ec_comment", :limit => 4000
    t.decimal "num_tabs"
    t.decimal "num_vars"
  end

  add_index "rule_ec$", ["obj#"], :name => "i_rule_ec", :unique => true

  create_table "rule_map$", :id => false, :force => true do |t|
    t.decimal "r_obj#",                     :null => false
    t.decimal "rs_obj#",                    :null => false
    t.decimal "property",                   :null => false
    t.decimal "ectx#"
    t.string  "rm_comment", :limit => 4000
  end

  add_index "rule_map$", ["r_obj#"], :name => "i_rule_map2"
  add_index "rule_map$", ["rs_obj#"], :name => "i_rule_map1"

  create_table "rule_set$", :id => false, :force => true do |t|
    t.decimal "obj#",                       :null => false
    t.decimal "ectx#"
    t.decimal "property"
    t.string  "rs_comment", :limit => 4000
    t.decimal "num_rules"
  end

  add_index "rule_set$", ["obj#"], :name => "i_rule_set", :unique => true

  create_table "rule_set_ee$", :id => false, :force => true do |t|
    t.decimal "rs_obj#",   :null => false
    t.decimal "ectx#",     :null => false
    t.decimal "num_rules"
    t.decimal "num_boxes"
    t.decimal "ee_flags"
  end

  add_index "rule_set_ee$", ["rs_obj#", "ectx#"], :name => "i_rule_set_ee", :unique => true

  create_table "rule_set_fob$", :id => false, :force => true do |t|
    t.decimal "rs_obj#",                 :null => false
    t.decimal "ec_obj#",                 :null => false
    t.decimal "box_id",                  :null => false
    t.decimal "box_type"
    t.decimal "opr_type"
    t.decimal "oet_type"
    t.decimal "oeflags"
    t.decimal "num_exprs"
    t.decimal "opexpr_n1"
    t.decimal "opexpr_n2"
    t.decimal "opexpr_n3"
    t.string  "opexpr_c1", :limit => 30
  end

  add_index "rule_set_fob$", ["rs_obj#", "ec_obj#", "box_id"], :name => "i_rule_set_fob", :unique => true

  create_table "rule_set_ieuac$", :primary_key => "client_name", :force => true do |t|
    t.string "export_function", :limit => 100
    t.string "cli_comment",     :limit => 4000
  end

  create_table "rule_set_iot$", :id => false, :force => true do |t|
    t.decimal "rs_obj#",                      :null => false
    t.decimal "ec_obj#",                      :null => false
    t.decimal "box_id",                       :null => false
    t.raw     "value",         :limit => 300, :null => false
    t.decimal "rule_id",                      :null => false
    t.decimal "rule_or_piece",                :null => false
    t.decimal "rop_id",                       :null => false
  end

  add_index "rule_set_iot$", ["rs_obj#", "ec_obj#", "rule_id", "rule_or_piece", "rop_id"], :name => "i_rule_set_iot", :tablespace => "sysaux"

  create_table "rule_set_nl$", :id => false, :force => true do |t|
    t.decimal "rs_obj#",               :null => false
    t.decimal "ec_obj#",               :null => false
    t.decimal "box_id",                :null => false
    t.decimal "ne_id",                 :null => false
    t.string  "name",    :limit => 30
    t.decimal "attr_id"
    t.raw     "toid",    :limit => 16
    t.decimal "version"
  end

  add_index "rule_set_nl$", ["rs_obj#", "ec_obj#", "box_id", "ne_id"], :name => "i_rule_set_nl", :unique => true

  create_table "rule_set_pr$", :id => false, :force => true do |t|
    t.decimal "rs_obj#",                      :null => false
    t.decimal "ec_obj#",                      :null => false
    t.decimal "rule_id",                      :null => false
    t.decimal "rule_or_piece",                :null => false
    t.decimal "rop_id",                       :null => false
    t.decimal "eval_id",                      :null => false
    t.decimal "pr_id",                        :null => false
    t.raw     "value",         :limit => 300
  end

  create_table "rule_set_rdep$", :id => false, :force => true do |t|
    t.decimal  "rs_obj#", :null => false
    t.decimal  "dp_obj#", :null => false
    t.datetime "dp_tmsp", :null => false
    t.decimal  "ec_obj#"
    t.decimal  "rule_id"
    t.decimal  "isin_dp"
  end

  add_index "rule_set_rdep$", ["dp_obj#", "dp_tmsp", "isin_dp"], :name => "i_rule_set_rdep2"
  add_index "rule_set_rdep$", ["rs_obj#", "dp_obj#", "isin_dp"], :name => "i_rule_set_rdep1"

  create_table "rule_set_re$", :id => false, :force => true do |t|
    t.decimal "rs_obj#",   :null => false
    t.decimal "ec_obj#",   :null => false
    t.decimal "rule_id",   :null => false
    t.decimal "r_obj#"
    t.decimal "r_orcount"
    t.decimal "r_lowbox"
    t.raw     "tabs_used"
    t.raw     "vars_used"
    t.decimal "property"
    t.decimal "ent_used"
  end

  add_index "rule_set_re$", ["rs_obj#", "ec_obj#", "ent_used"], :name => "i2_rule_set_re"
  add_index "rule_set_re$", ["rs_obj#", "ec_obj#", "rule_id"], :name => "i1_rule_set_re", :unique => true
  add_index "rule_set_re$", ["rs_obj#", "r_obj#", "ec_obj#"], :name => "i3_rule_set_re"

  create_table "rule_set_rop$", :id => false, :force => true do |t|
    t.decimal "rs_obj#",       :null => false
    t.decimal "ec_obj#",       :null => false
    t.decimal "rule_id",       :null => false
    t.decimal "rule_or_piece", :null => false
    t.decimal "rop_id",        :null => false
    t.decimal "eval_id",       :null => false
    t.decimal "box_id"
  end

  create_table "rule_set_ror$", :id => false, :force => true do |t|
    t.decimal "rs_obj#",       :null => false
    t.decimal "ec_obj#",       :null => false
    t.decimal "rule_id",       :null => false
    t.decimal "rule_or_piece", :null => false
    t.decimal "num_rops"
    t.decimal "box_id"
    t.decimal "property"
  end

  add_index "rule_set_ror$", ["rs_obj#", "ec_obj#", "rule_id", "rule_or_piece"], :name => "i_rule_set_ror", :unique => true

  create_table "rule_set_te$", :id => false, :force => true do |t|
    t.decimal "rs_obj#",  :null => false
    t.decimal "ec_obj#",  :null => false
    t.decimal "tab_id",   :null => false
    t.raw     "srchcols"
  end

  add_index "rule_set_te$", ["rs_obj#", "ec_obj#", "tab_id"], :name => "i_rule_set_te", :unique => true

  create_table "rule_set_ve$", :id => false, :force => true do |t|
    t.decimal "rs_obj#",   :null => false
    t.decimal "ec_obj#",   :null => false
    t.decimal "var_id",    :null => false
    t.decimal "num_attrs"
    t.decimal "num_mthds"
  end

  add_index "rule_set_ve$", ["rs_obj#", "ec_obj#", "var_id"], :name => "i_rule_set_ve", :unique => true

  create_table "ruleset$", :id => false, :force => true do |t|
    t.decimal "obj#",        :null => false
    t.decimal "baseobj",     :null => false
    t.decimal "rules_table", :null => false
  end

  create_table "scheduler$_chain", :primary_key => "obj#", :force => true do |t|
    t.string  "rule_set",       :limit => 30
    t.string  "rule_set_owner", :limit => 30
    t.string  "comments",       :limit => 240
    t.integer "eval_interval",  :limit => 3
    t.decimal "flags"
  end

  create_table "scheduler$_class", :primary_key => "obj#", :force => true do |t|
    t.string  "res_grp_name",     :limit => 30
    t.decimal "default_priority"
    t.string  "affinity",         :limit => 64
    t.decimal "log_history"
    t.decimal "flags"
    t.string  "comments",         :limit => 240
  end

  create_table "scheduler$_event_log", :primary_key => "log_id", :force => true do |t|
    t.timestamp "log_date",        :limit => 6
    t.decimal   "type#"
    t.string    "name",            :limit => 65
    t.string    "owner",           :limit => 30
    t.decimal   "class_id"
    t.string    "operation",       :limit => 30
    t.string    "status",          :limit => 30
    t.string    "user_name",       :limit => 30
    t.string    "client_id",       :limit => 64
    t.string    "guid",            :limit => 32
    t.text      "additional_info"
  end

# Could not dump table "scheduler$_event_qtab" because of following StandardError
#   Unknown type 'SCHEDULER$_EVENT_INFO' for column 'user_data'

  create_table "scheduler$_evtq_sub", :primary_key => "agt_name", :force => true do |t|
    t.string "uname", :limit => 30, :null => false
  end

  create_table "scheduler$_global_attribute", :primary_key => "obj#", :force => true do |t|
    t.string    "value",           :limit => 128
    t.decimal   "flags"
    t.decimal   "modified_inst"
    t.string    "additional_info", :limit => 128
    t.timestamp "attr_tstamp",     :limit => 6
    t.integer   "attr_intv",       :limit => 3
  end

  create_table "scheduler$_job", :primary_key => "obj#", :force => true do |t|
    t.decimal   "program_oid"
    t.string    "program_action",    :limit => 4000
    t.string    "schedule_expr",     :limit => 4000
    t.string    "queue_owner",       :limit => 30
    t.string    "queue_name",        :limit => 30
    t.string    "queue_agent",       :limit => 30
    t.string    "event_rule",        :limit => 65
    t.integer   "schedule_limit",    :limit => 3
    t.decimal   "schedule_id"
    t.timestamp "start_date",        :limit => 6
    t.timestamp "end_date",          :limit => 6
    t.timestamp "last_enabled_time", :limit => 6
    t.decimal   "class_oid"
    t.decimal   "priority"
    t.decimal   "job_weight"
    t.decimal   "number_of_args"
    t.decimal   "max_runs"
    t.decimal   "max_failures"
    t.integer   "max_run_duration",  :limit => 3
    t.raw       "mxdur_msgid",       :limit => 16
    t.decimal   "flags"
    t.string    "comments",          :limit => 240
    t.string    "user_callback",     :limit => 92
    t.decimal   "user_callback_ctx"
    t.string    "creator",           :limit => 30
    t.string    "client_id",         :limit => 64
    t.string    "guid",              :limit => 32
    t.string    "nls_env",           :limit => 4000
    t.raw       "env",               :limit => 32
    t.string    "char_env",          :limit => 4000
    t.string    "source",            :limit => 128
    t.string    "destination",       :limit => 128
    t.decimal   "job_status"
    t.timestamp "next_run_date",     :limit => 6
    t.timestamp "last_start_date",   :limit => 6
    t.timestamp "last_end_date",     :limit => 6
    t.decimal   "retry_count"
    t.decimal   "run_count"
    t.decimal   "failure_count"
    t.decimal   "running_instance"
    t.decimal   "running_slave"
  end

  add_index "scheduler$_job", ["BITAND(\"JOB_STATUS\",515)"], :name => "i_scheduler_job4"
  add_index "scheduler$_job", ["SYS_EXTRACT_UTC(\"NEXT_RUN_DATE\")"], :name => "i_scheduler_job1"
  add_index "scheduler$_job", ["class_oid"], :name => "i_scheduler_job2"
  add_index "scheduler$_job", ["schedule_id"], :name => "i_scheduler_job3"

# Could not dump table "scheduler$_job_argument" because of following StandardError
#   Unknown type 'ANYDATA' for column 'value'

  create_table "scheduler$_job_run_details", :id => false, :force => true do |t|
    t.decimal   "log_id"
    t.timestamp "log_date",        :limit => 6
    t.timestamp "req_start_date",  :limit => 6
    t.timestamp "start_date",      :limit => 6
    t.integer   "run_duration",    :limit => 3
    t.decimal   "instance_id"
    t.string    "session_id",      :limit => 30
    t.string    "slave_pid",       :limit => 30
    t.integer   "cpu_used",        :limit => 3
    t.decimal   "error#"
    t.string    "additional_info", :limit => 4000
  end

# Could not dump table "scheduler$_jobqtab" because of following StandardError
#   Unknown type 'ANYDATA' for column 'user_data'

  create_table "scheduler$_oldoids", :primary_key => "idseq", :force => true do |t|
    t.decimal "oldoid", :null => false
  end

  create_table "scheduler$_program", :primary_key => "obj#", :force => true do |t|
    t.string  "action",         :limit => 4000
    t.decimal "number_of_args"
    t.string  "comments",       :limit => 240
    t.decimal "flags"
    t.decimal "run_count"
  end

# Could not dump table "scheduler$_program_argument" because of following StandardError
#   Unknown type 'ANYDATA' for column 'value'

  create_table "scheduler$_schedule", :primary_key => "obj#", :force => true do |t|
    t.string    "recurrence_expr", :limit => 4000
    t.string    "queue_owner",     :limit => 30
    t.string    "queue_name",      :limit => 30
    t.string    "queue_agent",     :limit => 30
    t.timestamp "reference_date",  :limit => 6
    t.timestamp "end_date",        :limit => 6
    t.string    "comments",        :limit => 240
    t.decimal   "flags"
    t.decimal   "max_count"
  end

  create_table "scheduler$_srcq_info", :primary_key => "obj#", :force => true do |t|
    t.string  "ruleset_name", :limit => 30
    t.decimal "rule_count"
    t.decimal "flags"
  end

  create_table "scheduler$_srcq_map", :id => false, :force => true do |t|
    t.decimal "oid",                     :null => false
    t.string  "rule_name", :limit => 65, :null => false
    t.decimal "joboid",                  :null => false
  end

  create_table "scheduler$_step", :id => false, :force => true do |t|
    t.decimal "oid",                         :null => false
    t.string  "var_name",    :limit => 30,   :null => false
    t.string  "object_name", :limit => 98
    t.integer "timeout",     :limit => 3
    t.string  "queue_owner", :limit => 30
    t.string  "queue_name",  :limit => 30
    t.string  "queue_agent", :limit => 30
    t.string  "condition",   :limit => 4000
    t.decimal "flags",                       :null => false
  end

  add_index "scheduler$_step", ["oid"], :name => "i_scheduler_step1"

  create_table "scheduler$_step_state", :id => false, :force => true do |t|
    t.decimal   "job_oid",                        :null => false
    t.string    "step_name",       :limit => 30,  :null => false
    t.string    "status",          :limit => 1
    t.decimal   "error_code"
    t.timestamp "start_date",      :limit => 6
    t.timestamp "end_date",        :limit => 6
    t.decimal   "job_step_oid"
    t.decimal   "job_step_log_id"
    t.string    "destination",     :limit => 128
    t.decimal   "flags"
  end

  create_table "scheduler$_window", :primary_key => "obj#", :force => true do |t|
    t.string    "res_plan",            :limit => 30
    t.timestamp "next_start_date",     :limit => 6
    t.timestamp "manual_open_time",    :limit => 6
    t.integer   "duration",            :limit => 3
    t.integer   "manual_duration",     :limit => 3
    t.string    "schedule_expr",       :limit => 4000
    t.timestamp "start_date",          :limit => 6
    t.timestamp "end_date",            :limit => 6
    t.timestamp "last_start_date",     :limit => 6
    t.timestamp "actual_start_date",   :limit => 6
    t.decimal   "scaling_factor"
    t.string    "creator",             :limit => 30
    t.decimal   "unused_slave_policy"
    t.decimal   "min_slave_percent"
    t.decimal   "max_slave_percent"
    t.decimal   "schedule_id"
    t.decimal   "flags"
    t.decimal   "max_conc_jobs"
    t.decimal   "priority"
    t.string    "comments",            :limit => 240
  end

  add_index "scheduler$_window", ["SYS_EXTRACT_UTC(\"NEXT_START_DATE\")"], :name => "i_scheduler_window1"

  create_table "scheduler$_window_details", :id => false, :force => true do |t|
    t.decimal   "log_id"
    t.timestamp "log_date",        :limit => 6
    t.decimal   "instance_id"
    t.timestamp "req_start_date",  :limit => 6
    t.timestamp "start_date",      :limit => 6
    t.integer   "duration",        :limit => 3
    t.integer   "actual_duration", :limit => 3
    t.string    "additional_info", :limit => 4000
  end

  create_table "scheduler$_window_group", :primary_key => "obj#", :force => true do |t|
    t.string  "comments", :limit => 240
    t.decimal "flags"
  end

  create_table "scheduler$_wingrp_member", :id => false, :force => true do |t|
    t.decimal "oid",        :null => false
    t.decimal "member_oid", :null => false
  end

  add_index "scheduler$_wingrp_member", ["member_oid"], :name => "i_scheduler_wingrp_member2"
  add_index "scheduler$_wingrp_member", ["oid"], :name => "i_scheduler_wingrp_member1"

  create_table "secobj$", :id => false, :force => true do |t|
    t.decimal "obj#",    :null => false
    t.decimal "secobj#", :null => false
    t.decimal "spare1"
    t.decimal "spare2"
  end

  create_table "seg$", :id => false, :force => true do |t|
    t.decimal "file#",        :null => false
    t.decimal "block#",       :null => false
    t.decimal "type#",        :null => false
    t.decimal "ts#",          :null => false
    t.decimal "blocks",       :null => false
    t.decimal "extents",      :null => false
    t.decimal "iniexts",      :null => false
    t.decimal "minexts",      :null => false
    t.decimal "maxexts",      :null => false
    t.decimal "extsize",      :null => false
    t.decimal "extpct",       :null => false
    t.decimal "user#",        :null => false
    t.decimal "lists"
    t.decimal "groups"
    t.decimal "bitmapranges", :null => false
    t.decimal "cachehint",    :null => false
    t.decimal "scanhint",     :null => false
    t.decimal "hwmincr",      :null => false
    t.decimal "spare1"
    t.decimal "spare2"
  end

  create_table "seq$", :id => false, :force => true do |t|
    t.decimal "obj#",                     :null => false
    t.decimal "increment$",               :null => false
    t.decimal "minvalue"
    t.decimal "maxvalue"
    t.decimal "cycle#",                   :null => false
    t.decimal "order$",                   :null => false
    t.decimal "cache",                    :null => false
    t.decimal "highwater",                :null => false
    t.string  "audit$",     :limit => 38, :null => false
    t.decimal "flags"
  end

  add_index "seq$", ["obj#"], :name => "i_seq1", :unique => true

  create_table "service$", :id => false, :force => true do |t|
    t.decimal  "service_id"
    t.string   "name",               :limit => 64
    t.decimal  "name_hash"
    t.string   "network_name",       :limit => 512
    t.datetime "creation_date"
    t.decimal  "creation_date_hash"
    t.datetime "deletion_date"
    t.string   "failover_method",    :limit => 64
    t.string   "failover_type",      :limit => 64
    t.integer  "failover_retries",   :limit => 10,  :precision => 10, :scale => 0
    t.integer  "failover_delay",     :limit => 10,  :precision => 10, :scale => 0
    t.decimal  "min_cardinality"
    t.decimal  "max_cardinality"
    t.decimal  "goal"
    t.decimal  "flags"
  end

  create_table "settings$", :id => false, :force => true do |t|
    t.decimal "obj#",                  :null => false
    t.string  "param", :limit => 30,   :null => false
    t.string  "value", :limit => 4000
  end

  add_index "settings$", ["obj#"], :name => "i_settings1"

  create_table "slog$", :id => false, :force => true do |t|
    t.string   "mowner",   :limit => 30,                                :null => false
    t.string   "master",   :limit => 30,                                :null => false
    t.datetime "snapshot"
    t.integer  "snapid",                 :precision => 38, :scale => 0
    t.decimal  "sscn"
    t.datetime "snaptime",                                              :null => false
    t.decimal  "tscn"
    t.decimal  "user#"
  end

  add_index "slog$", ["snaptime"], :name => "i_slog1"

  create_table "smon_scn_time", :id => false, :force => true do |t|
    t.decimal  "thread"
    t.decimal  "time_mp"
    t.datetime "time_dp"
    t.decimal  "scn_wrp"
    t.decimal  "scn_bas"
    t.decimal  "num_mappings"
    t.raw      "tim_scn_map",  :limit => 1200
    t.decimal  "scn",                          :default => 0.0
    t.decimal  "orig_thread",                  :default => 0.0
  end

  add_index "smon_scn_time", ["scn"], :name => "smon_scn_time_scn_idx", :unique => true
  add_index "smon_scn_time", ["time_mp"], :name => "smon_scn_time_tim_idx", :unique => true

# Could not dump table "snap$" because of following StandardError
#   Unknown type 'LONG' for column 'query_txt'

  create_table "snap_colmap$", :id => false, :force => true do |t|
    t.string  "sowner",   :limit => 30,                                               :null => false
    t.string  "vname",    :limit => 30,                                               :null => false
    t.string  "snacol",   :limit => 30,                                               :null => false
    t.integer "tabnum",                 :precision => 38, :scale => 0,                :null => false
    t.string  "mascol",   :limit => 30
    t.integer "maspos",                 :precision => 38, :scale => 0
    t.decimal "colrole"
    t.integer "instsite",               :precision => 38, :scale => 0, :default => 0
    t.integer "snapos",                 :precision => 38, :scale => 0, :default => 0
  end

  add_index "snap_colmap$", ["sowner", "vname", "instsite", "tabnum", "snacol"], :name => "i_snap_colmap1", :unique => true

  create_table "snap_loadertime$", :id => false, :force => true do |t|
    t.decimal  "tableobj#"
    t.datetime "oldest"
    t.datetime "youngest"
    t.decimal  "flag"
  end

  add_index "snap_loadertime$", ["tableobj#"], :name => "i_snap_loadertime1", :unique => true

  create_table "snap_logdep$", :id => false, :force => true do |t|
    t.decimal  "tableobj#"
    t.integer  "snapid",    :precision => 38, :scale => 0
    t.datetime "snaptime"
  end

  add_index "snap_logdep$", ["tableobj#", "snapid"], :name => "i_snap_logdep1", :unique => true

  create_table "snap_objcol$", :id => false, :force => true do |t|
    t.string  "sowner",            :limit => 30,                                               :null => false
    t.string  "vname",             :limit => 30,                                               :null => false
    t.integer "instsite",                        :precision => 38, :scale => 0, :default => 0
    t.integer "tabnum",                          :precision => 38, :scale => 0,                :null => false
    t.string  "snacol",            :limit => 30,                                               :null => false
    t.string  "mascol",            :limit => 30
    t.decimal "flag"
    t.string  "storage_tab_owner", :limit => 30
    t.string  "storage_tab_name",  :limit => 30
    t.raw     "sna_type_oid",      :limit => 16
    t.raw     "sna_type_hashcode", :limit => 17
    t.string  "sna_type_owner",    :limit => 30
    t.string  "sna_type_name",     :limit => 30
    t.raw     "mas_type_oid",      :limit => 16
    t.raw     "mas_type_hashcode", :limit => 17
    t.string  "mas_type_owner",    :limit => 30
    t.string  "mas_type_name",     :limit => 30
  end

  add_index "snap_objcol$", ["sowner", "vname", "instsite", "tabnum", "snacol"], :name => "i_snap_objcol1", :unique => true

# Could not dump table "snap_refop$" because of following StandardError
#   Unknown type 'LONG' for column 'sql_txt'

  create_table "snap_reftime$", :id => false, :force => true do |t|
    t.string   "sowner",      :limit => 30,                                                :null => false
    t.string   "vname",       :limit => 30,                                                :null => false
    t.integer  "tablenum",                   :precision => 38, :scale => 0,                :null => false
    t.datetime "snaptime"
    t.string   "mowner",      :limit => 30
    t.string   "master",      :limit => 30
    t.decimal  "masflag"
    t.decimal  "masobj#"
    t.datetime "loadertime"
    t.decimal  "refscn"
    t.integer  "instsite",                   :precision => 38, :scale => 0, :default => 0
    t.datetime "lastsuccess"
    t.raw      "fcmaskvec",   :limit => 255
    t.raw      "ejmaskvec",   :limit => 255
    t.decimal  "sub_handle"
    t.string   "change_view", :limit => 30
  end

  add_index "snap_reftime$", ["vname", "sowner", "instsite", "tablenum"], :name => "i_snap_reftime1", :unique => true

  create_table "snap_site$", :id => false, :force => true do |t|
    t.string  "site_name", :limit => 128,                                :null => false
    t.integer "site_id",                  :precision => 38, :scale => 0
  end

  add_index "snap_site$", ["site_name"], :name => "i_snap_site1", :unique => true

  create_table "source$", :id => false, :force => true do |t|
    t.decimal "obj#",                   :null => false
    t.decimal "line",                   :null => false
    t.string  "source", :limit => 4000
  end

  add_index "source$", ["obj#", "line"], :name => "i_source1", :unique => true

  create_table "sql$", :id => false, :force => true do |t|
    t.decimal  "signature",                      :null => false
    t.decimal  "nhash",                          :null => false
    t.decimal  "sqlarea_hash",                   :null => false
    t.datetime "last_used",                      :null => false
    t.decimal  "inuse_features",                 :null => false
    t.decimal  "flags",                          :null => false
    t.datetime "modified",                       :null => false
    t.decimal  "incarnation",                    :null => false
    t.decimal  "spare1"
    t.string   "spare2",         :limit => 1000
  end

  add_index "sql$", ["signature"], :name => "i_sql$signature", :unique => true

  create_table "sql$text", :id => false, :force => true do |t|
    t.decimal "signature", :null => false
    t.text    "sql_text",  :null => false
    t.decimal "sql_len",   :null => false
  end

  add_index "sql$text", ["signature"], :name => "i_sql$text"

  create_table "sql_version$", :id => false, :force => true do |t|
    t.decimal "version#",                  :null => false
    t.string  "sql_version", :limit => 30
  end

  add_index "sql_version$", ["version#"], :name => "i_sql_version$_version#", :unique => true

  create_table "sqlprof$", :id => false, :force => true do |t|
    t.string   "sp_name",       :limit => 30,   :null => false
    t.decimal  "signature",                     :null => false
    t.string   "category",      :limit => 30,   :null => false
    t.decimal  "nhash",                         :null => false
    t.datetime "created",                       :null => false
    t.datetime "last_modified",                 :null => false
    t.decimal  "type",                          :null => false
    t.decimal  "status",                        :null => false
    t.decimal  "flags",                         :null => false
    t.decimal  "spare1"
    t.string   "spare2",        :limit => 1000
  end

  add_index "sqlprof$", ["signature", "category"], :name => "i_sqlprof$", :unique => true
  add_index "sqlprof$", ["sp_name"], :name => "i_sqlprof$name", :unique => true

  create_table "sqlprof$attr", :id => false, :force => true do |t|
    t.decimal "signature",                :null => false
    t.string  "category",  :limit => 30,  :null => false
    t.decimal "attr#",                    :null => false
    t.string  "attr_val",  :limit => 500, :null => false
  end

  add_index "sqlprof$attr", ["signature", "category", "attr#"], :name => "i_sqlprof$attr", :unique => true

  create_table "sqlprof$desc", :id => false, :force => true do |t|
    t.decimal "signature",                  :null => false
    t.string  "category",    :limit => 30,  :null => false
    t.string  "description", :limit => 500
  end

  add_index "sqlprof$desc", ["signature", "category"], :name => "i_sqlprof$desc", :unique => true

  create_table "stats_target$", :id => false, :force => true do |t|
    t.decimal "staleness", :null => false
    t.decimal "osize",     :null => false
    t.decimal "obj#",      :null => false
    t.decimal "type#",     :null => false
    t.decimal "flags",     :null => false
    t.decimal "status",    :null => false
    t.decimal "sid"
    t.decimal "serial#"
    t.decimal "part#"
    t.decimal "bo#"
  end

  add_index "stats_target$", ["obj#"], :name => "i_stats_target2", :unique => true, :tablespace => "sysaux"
  add_index "stats_target$", ["staleness", "osize", "obj#", "status"], :name => "i_stats_target1", :tablespace => "sysaux"

  create_table "stmt_audit_option_map", :id => false, :force => true do |t|
    t.decimal "option#",                :null => false
    t.string  "name",     :limit => 40, :null => false
    t.decimal "property",               :null => false
  end

  add_index "stmt_audit_option_map", ["option#", "name"], :name => "i_stmt_audit_option_map", :unique => true

  create_table "streams$_apply_milestone", :id => false, :force => true do |t|
    t.decimal  "apply#",                                     :null => false
    t.string   "source_db_name",              :limit => 128, :null => false
    t.decimal  "oldest_scn",                                 :null => false
    t.decimal  "commit_scn",                                 :null => false
    t.decimal  "synch_scn",                                  :null => false
    t.decimal  "epoch",                                      :null => false
    t.decimal  "processed_scn",                              :null => false
    t.datetime "apply_time"
    t.datetime "applied_message_create_time"
    t.decimal  "spare1"
    t.decimal  "start_scn"
    t.string   "oldest_transaction_id",       :limit => 22
  end

  add_index "streams$_apply_milestone", ["apply#", "source_db_name"], :name => "i_streams_apply_milestone1", :unique => true

  create_table "streams$_apply_process", :id => false, :force => true do |t|
    t.decimal  "apply#",                                  :null => false
    t.string   "apply_name",              :limit => 30,   :null => false
    t.raw      "queue_oid",               :limit => 16,   :null => false
    t.string   "queue_owner",             :limit => 30,   :null => false
    t.string   "queue_name",              :limit => 30,   :null => false
    t.decimal  "status"
    t.decimal  "flags"
    t.string   "ruleset_owner",           :limit => 30
    t.string   "ruleset_name",            :limit => 30
    t.string   "message_handler",         :limit => 98
    t.string   "ddl_handler",             :limit => 98
    t.string   "precommit_handler",       :limit => 98
    t.decimal  "apply_userid"
    t.string   "apply_dblink",            :limit => 128
    t.raw      "apply_tag"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "negative_ruleset_owner",  :limit => 30
    t.string   "negative_ruleset_name",   :limit => 30
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal  "error_number"
    t.string   "error_message",           :limit => 4000
    t.datetime "status_change_time"
    t.string   "ua_notification_handler", :limit => 98
    t.string   "ua_ruleset_owner",        :limit => 30
    t.string   "ua_ruleset_name",         :limit => 30
  end

  add_index "streams$_apply_process", ["apply#"], :name => "i_streams_apply_process1", :unique => true
  add_index "streams$_apply_process", ["apply_name"], :name => "i_streams_apply_process2", :unique => true
  add_index "streams$_apply_process", ["queue_oid"], :name => "i_streams_apply_process3"

  create_table "streams$_apply_progress", :id => false, :force => true do |t|
    t.decimal "apply#"
    t.string  "source_db_name", :limit => 128
    t.decimal "xidusn"
    t.decimal "xidslt"
    t.decimal "xidsqn"
    t.decimal "commit_scn"
    t.decimal "spare1"
  end

# Could not dump table "streams$_apply_spill_messages" because of following StandardError
#   Unknown type 'ANYDATA' for column 'message'

# Could not dump table "streams$_apply_spill_msgs_part" because of following StandardError
#   Unknown type 'ANYDATA' for column 'message'

  create_table "streams$_apply_spill_txn", :id => false, :force => true do |t|
    t.string   "applyname",                 :limit => 30,   :null => false
    t.decimal  "xidusn",                                    :null => false
    t.decimal  "xidslt",                                    :null => false
    t.decimal  "xidsqn",                                    :null => false
    t.decimal  "first_scn",                                 :null => false
    t.decimal  "last_scn"
    t.decimal  "last_scn_seq"
    t.decimal  "last_cap_instno"
    t.decimal  "commit_scn"
    t.decimal  "spillcount"
    t.decimal  "err_num"
    t.decimal  "err_idx"
    t.string   "sender",                    :limit => 30
    t.decimal  "flags"
    t.decimal  "priv_state"
    t.decimal  "distrib_cscn"
    t.decimal  "src_commit_time"
    t.decimal  "dep_flag"
    t.decimal  "spill_flags"
    t.datetime "first_message_create_time"
    t.datetime "spill_creation_time"
    t.decimal  "txnkey"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.decimal  "spare4"
    t.string   "spare5",                    :limit => 4000
    t.string   "spare6",                    :limit => 4000
    t.string   "spare7",                    :limit => 4000
  end

  add_index "streams$_apply_spill_txn", ["applyname", "xidusn", "xidslt", "xidsqn"], :name => "i_streams_apply_spill_txn", :unique => true, :tablespace => "sysaux"

  create_table "streams$_apply_spill_txn_list", :id => false, :force => true do |t|
    t.decimal "txnkey"
    t.string  "status", :limit => 1
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3", :limit => 4000
    t.string  "spare4", :limit => 4000
  end

  create_table "streams$_capture_process", :id => false, :force => true do |t|
    t.raw      "queue_oid",              :limit => 16,   :null => false
    t.string   "queue_owner",            :limit => 30,   :null => false
    t.string   "queue_name",             :limit => 30,   :null => false
    t.decimal  "capture#",                               :null => false
    t.string   "capture_name",           :limit => 30,   :null => false
    t.decimal  "status"
    t.string   "ruleset_owner",          :limit => 30
    t.string   "ruleset_name",           :limit => 30
    t.decimal  "logmnr_sid"
    t.decimal  "predumpscn"
    t.decimal  "dumpseqbeg"
    t.decimal  "dumpseqend"
    t.decimal  "postdumpscn"
    t.decimal  "flags"
    t.decimal  "start_scn"
    t.decimal  "capture_userid"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.decimal  "use_dblink"
    t.decimal  "first_scn"
    t.string   "source_dbname",          :limit => 128
    t.string   "negative_ruleset_owner", :limit => 30
    t.string   "negative_ruleset_name",  :limit => 30
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal  "error_number"
    t.string   "error_message",          :limit => 4000
    t.datetime "status_change_time"
    t.string   "version",                :limit => 64
    t.decimal  "spare4"
    t.decimal  "spare5"
    t.decimal  "spare6"
    t.string   "spare7",                 :limit => 1000
  end

  add_index "streams$_capture_process", ["capture#"], :name => "i_streams_capture_process1", :unique => true
  add_index "streams$_capture_process", ["capture_name"], :name => "i_streams_capture_process2", :unique => true

  create_table "streams$_def_proc", :id => false, :force => true do |t|
    t.decimal  "base_obj_num"
    t.decimal  "flags"
    t.string   "owner",           :limit => 30
    t.string   "package_name",    :limit => 30
    t.string   "procedure_name",  :limit => 30
    t.string   "param_name",      :limit => 30
    t.decimal  "param_type"
    t.raw      "raw_value"
    t.decimal  "number_value"
    t.datetime "date_value"
    t.string   "varchar2_value",  :limit => 4000
    t.string   "nvarchar2_value", :limit => nil
    t.text     "clob_value"
    t.binary   "blob_value"
    t.text     "nclob_value"
  end

  create_table "streams$_dest_obj_cols", :id => false, :force => true do |t|
    t.decimal "object_number"
    t.string  "column_name",   :limit => 30
    t.decimal "flag"
    t.string  "dblink",        :limit => 128
    t.decimal "spare1"
    t.string  "spare2",        :limit => 1000
  end

  add_index "streams$_dest_obj_cols", ["object_number", "column_name", "dblink"], :name => "streams$_dest_obj_cols_i", :unique => true

  create_table "streams$_dest_objs", :id => false, :force => true do |t|
    t.decimal "object_number"
    t.decimal "property"
    t.string  "dblink",        :limit => 128
    t.decimal "spare1"
    t.decimal "spare2"
    t.string  "spare3",        :limit => 1000
    t.string  "spare4",        :limit => 1000
  end

  add_index "streams$_dest_objs", ["object_number", "dblink"], :name => "streams$_dest_objs_i", :unique => true

  create_table "streams$_extra_attrs", :id => false, :force => true do |t|
    t.decimal "process#",                 :null => false
    t.string  "name",     :limit => 30,   :null => false
    t.string  "include",  :limit => 30
    t.decimal "flag"
    t.decimal "spare1"
    t.string  "spare2",   :limit => 1000
  end

  add_index "streams$_extra_attrs", ["process#", "name"], :name => "i_streams_extra_attrs1", :unique => true

# Could not dump table "streams$_internal_transform" because of following StandardError
#   Unknown type 'ANYDATA' for column 'column_value'

  create_table "streams$_key_columns", :id => false, :force => true do |t|
    t.string  "sname",      :limit => 30,   :null => false
    t.string  "oname",      :limit => 30,   :null => false
    t.decimal "type",                       :null => false
    t.string  "cname",      :limit => 30,   :null => false
    t.string  "dblink",     :limit => 128
    t.string  "long_cname", :limit => 4000
    t.decimal "spare1"
  end

  add_index "streams$_key_columns", ["sname", "oname", "type", "cname", "dblink"], :name => "i_streams_key_columns", :unique => true

  create_table "streams$_message_consumers", :id => false, :force => true do |t|
    t.string  "streams_name",   :limit => 30,  :null => false
    t.raw     "queue_oid",      :limit => 16,  :null => false
    t.string  "queue_owner",    :limit => 30,  :null => false
    t.string  "queue_name",     :limit => 30,  :null => false
    t.string  "rset_owner",     :limit => 30
    t.string  "rset_name",      :limit => 30
    t.string  "neg_rset_owner", :limit => 30
    t.string  "neg_rset_name",  :limit => 30
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
    t.string  "spare4",         :limit => 30
    t.string  "spare5",         :limit => 128
  end

  add_index "streams$_message_consumers", ["streams_name"], :name => "i_streams_message_consumers", :unique => true

  create_table "streams$_message_rules", :id => false, :force => true do |t|
    t.string  "streams_name",   :limit => 30,   :null => false
    t.decimal "streams_type",                   :null => false
    t.string  "msg_type_owner", :limit => 30
    t.string  "msg_type_name",  :limit => 30
    t.string  "msg_rule_var",   :limit => 30
    t.string  "rule_owner",     :limit => 30,   :null => false
    t.string  "rule_name",      :limit => 30,   :null => false
    t.string  "rule_condition", :limit => 4000
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
    t.string  "spare4",         :limit => 30
    t.string  "spare5",         :limit => 128
  end

  add_index "streams$_message_rules", ["streams_name", "streams_type", "rule_owner", "rule_name"], :name => "i_streams_message_rules", :unique => true

  create_table "streams$_prepare_ddl", :id => false, :force => true do |t|
    t.decimal  "global_flag",                 :null => false
    t.decimal  "usrid"
    t.decimal  "scn"
    t.datetime "timestamp"
    t.decimal  "flags"
    t.decimal  "spare1"
    t.string   "spare2",      :limit => 1000
  end

  add_index "streams$_prepare_ddl", ["global_flag", "usrid"], :name => "i_streams_prepare_ddl", :unique => true

  create_table "streams$_prepare_object", :id => false, :force => true do |t|
    t.decimal  "obj#",                       :null => false
    t.decimal  "ignore_scn",                 :null => false
    t.datetime "timestamp"
    t.decimal  "flags"
    t.decimal  "spare1"
    t.string   "spare2",     :limit => 1000
  end

  add_index "streams$_prepare_object", ["obj#"], :name => "i_streams_prepare1", :unique => true

  create_table "streams$_privileged_user", :id => false, :force => true do |t|
    t.decimal "user#", :null => false
    t.decimal "privs", :null => false
  end

  add_index "streams$_privileged_user", ["user#"], :name => "i_streams_privileged_user1", :unique => true

  create_table "streams$_process_params", :id => false, :force => true do |t|
    t.decimal "process_type",                      :null => false
    t.decimal "process#",                          :null => false
    t.string  "name",              :limit => 128,  :null => false
    t.string  "value",             :limit => 4000
    t.decimal "user_changed_flag"
    t.decimal "internal_flag"
    t.decimal "spare1"
  end

  add_index "streams$_process_params", ["process_type", "process#", "name"], :name => "i_streams_process_params1", :unique => true

  create_table "streams$_propagation_process", :id => false, :force => true do |t|
    t.string  "propagation_name",         :limit => 30,  :null => false
    t.string  "source_queue_schema",      :limit => 30
    t.string  "source_queue",             :limit => 30
    t.string  "destination_queue_schema", :limit => 30
    t.string  "destination_queue",        :limit => 30
    t.string  "destination_dblink",       :limit => 128
    t.string  "ruleset_schema",           :limit => 30
    t.string  "ruleset",                  :limit => 30
    t.decimal "spare1"
    t.string  "spare2",                   :limit => 128
    t.string  "negative_ruleset_schema",  :limit => 30
    t.string  "negative_ruleset",         :limit => 30
  end

  add_index "streams$_propagation_process", ["propagation_name"], :name => "streams$_prop_p_i1", :unique => true
  add_index "streams$_propagation_process", ["source_queue_schema", "source_queue", "destination_queue_schema", "destination_queue", "destination_dblink"], :name => "streams$_prop_p_i2", :unique => true

  create_table "streams$_rules", :id => false, :force => true do |t|
    t.string  "streams_name",         :limit => 30
    t.decimal "streams_type"
    t.decimal "rule_type"
    t.decimal "include_tagged_lcr"
    t.string  "source_database",      :limit => 128
    t.string  "rule_owner",           :limit => 30
    t.string  "rule_name",            :limit => 30
    t.string  "rule_condition",       :limit => 4000
    t.string  "dml_condition",        :limit => 4000
    t.decimal "subsetting_operation"
    t.string  "schema_name",          :limit => 30
    t.string  "object_name",          :limit => 30
    t.decimal "object_type"
    t.string  "and_condition",        :limit => 4000
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
  end

  add_index "streams$_rules", ["rule_owner", "rule_name"], :name => "i_streams_rules1", :unique => true
  add_index "streams$_rules", ["schema_name", "object_name"], :name => "i_streams_rules2"

  create_table "subcoltype$", :id => false, :force => true do |t|
    t.decimal "obj#",                   :null => false
    t.decimal "intcol#",                :null => false
    t.raw     "toid",     :limit => 16, :null => false
    t.decimal "version#",               :null => false
    t.decimal "intcols"
    t.raw     "intcol#s"
    t.decimal "flags"
    t.decimal "synobj#"
  end

  add_index "subcoltype$", ["obj#", "intcol#"], :name => "i_subcoltype1"

  create_table "subpartcol$", :id => false, :force => true do |t|
    t.decimal "obj#",        :null => false
    t.decimal "intcol#",     :null => false
    t.decimal "col#",        :null => false
    t.decimal "pos#",        :null => false
    t.decimal "spare1"
    t.decimal "segcol#",     :null => false
    t.decimal "type#",       :null => false
    t.decimal "charsetform"
  end

  add_index "subpartcol$", ["obj#"], :name => "i_subpartcol$"

# Could not dump table "sum$" because of following StandardError
#   Unknown type 'LONG' for column 'sumtext'

# Could not dump table "sumagg$" because of following StandardError
#   Unknown type 'LONG' for column 'aggtext'

# Could not dump table "sumdelta$" because of following StandardError
#   Unknown type 'ROWID' for column 'lowrowid'

# Could not dump table "sumdep$" because of following StandardError
#   Unknown type 'LONG' for column 'vw_query'

  create_table "sumdetail$", :id => false, :force => true do |t|
    t.decimal  "sumobj#",                       :null => false
    t.decimal  "detailobj#",                    :null => false
    t.decimal  "qbcid",                         :null => false
    t.decimal  "detailobjtype"
    t.string   "detailalias",   :limit => 30
    t.decimal  "refreshscn"
    t.decimal  "detaileut"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",        :limit => 1000
    t.datetime "spare4"
    t.decimal  "inline#"
    t.decimal  "instance#"
    t.decimal  "dataless"
  end

  add_index "sumdetail$", ["detailobj#"], :name => "i_sumdetail$_2"
  add_index "sumdetail$", ["sumobj#"], :name => "i_sumdetail$_1"

# Could not dump table "suminline$" because of following StandardError
#   Unknown type 'LONG' for column 'text'

  create_table "sumjoin$", :id => false, :force => true do |t|
    t.decimal  "sumobj#",                                                   :null => false
    t.decimal  "tab1obj#",                                                  :null => false
    t.decimal  "tab1col#",                                                  :null => false
    t.decimal  "tab2obj#",                                                  :null => false
    t.decimal  "tab2col#",                                                  :null => false
    t.decimal  "qbcid",                                                     :null => false
    t.integer  "joinop",                     :precision => 38, :scale => 0
    t.decimal  "flags"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",     :limit => 1000
    t.datetime "spare4"
    t.decimal  "inline1#"
    t.decimal  "inline2#"
    t.decimal  "instance1#"
    t.decimal  "instance2#"
  end

  add_index "sumjoin$", ["sumobj#", "tab1obj#"], :name => "i_sumjoin$_1"

# Could not dump table "sumkey$" because of following StandardError
#   Unknown type 'LONG' for column 'text'

# Could not dump table "sumpartlog$" because of following StandardError
#   Unknown type 'LONG' for column 'boundvals'

# Could not dump table "sumpred$" because of following StandardError
#   Unknown type 'LONG' for column 'value'

# Could not dump table "sumqb$" because of following StandardError
#   Unknown type 'LONG' for column 'text'

  create_table "superobj$", :id => false, :force => true do |t|
    t.decimal "subobj#",   :null => false
    t.decimal "superobj#", :null => false
  end

  add_index "superobj$", ["subobj#"], :name => "i_superobj1", :unique => true
  add_index "superobj$", ["superobj#"], :name => "i_superobj2"

  create_table "syn$", :id => false, :force => true do |t|
    t.decimal "obj#",                 :null => false
    t.string  "node",  :limit => 128
    t.string  "owner", :limit => 30
    t.string  "name",  :limit => 30,  :null => false
  end

  add_index "syn$", ["obj#"], :name => "i_syn1", :unique => true

# Could not dump table "sys$service_metrics_tab" because of following StandardError
#   Unknown type 'SYS$RLBTYP' for column 'user_data'

  create_table "sys_iot_over_10125", :id => false, :force => true do |t|
  end

  create_table "sys_iot_over_4468", :id => false, :force => true do |t|
  end

  create_table "sys_iot_over_4474", :id => false, :force => true do |t|
  end

  create_table "sys_iot_over_4478", :id => false, :force => true do |t|
  end

  create_table "sys_iot_over_5062", :id => false, :force => true do |t|
  end

  create_table "sys_iot_over_5148", :id => false, :force => true do |t|
  end

  create_table "sys_iot_over_7141", :id => false, :force => true do |t|
  end

  create_table "sys_iot_over_8638", :id => false, :force => true do |t|
  end

  create_table "sys_iot_over_8748", :id => false, :force => true do |t|
  end

  create_table "sys_iot_over_9641", :id => false, :force => true do |t|
  end

  create_table "sysauth$", :id => false, :force => true do |t|
    t.decimal "grantee#",   :null => false
    t.decimal "privilege#", :null => false
    t.decimal "sequence#",  :null => false
    t.decimal "option$"
  end

  add_index "sysauth$", ["grantee#", "privilege#"], :name => "i_sysauth1", :unique => true

  create_table "system_privilege_map", :id => false, :force => true do |t|
    t.decimal "privilege",               :null => false
    t.string  "name",      :limit => 40, :null => false
    t.decimal "property",                :null => false
  end

  add_index "system_privilege_map", ["privilege", "name"], :name => "i_system_privilege_map", :unique => true

  create_table "tab$", :id => false, :force => true do |t|
    t.decimal  "obj#",                        :null => false
    t.decimal  "dataobj#"
    t.decimal  "ts#",                         :null => false
    t.decimal  "file#",                       :null => false
    t.decimal  "block#",                      :null => false
    t.decimal  "bobj#"
    t.decimal  "tab#"
    t.decimal  "cols",                        :null => false
    t.decimal  "clucols"
    t.decimal  "pctfree$",                    :null => false
    t.decimal  "pctused$",                    :null => false
    t.decimal  "initrans",                    :null => false
    t.decimal  "maxtrans",                    :null => false
    t.decimal  "flags",                       :null => false
    t.string   "audit$",      :limit => 38,   :null => false
    t.decimal  "rowcnt"
    t.decimal  "blkcnt"
    t.decimal  "empcnt"
    t.decimal  "avgspc"
    t.decimal  "chncnt"
    t.decimal  "avgrln"
    t.decimal  "avgspc_flb"
    t.decimal  "flbcnt"
    t.datetime "analyzetime"
    t.decimal  "samplesize"
    t.decimal  "degree"
    t.decimal  "instances"
    t.decimal  "intcols",                     :null => false
    t.decimal  "kernelcols",                  :null => false
    t.decimal  "property",                    :null => false
    t.decimal  "trigflag"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",      :limit => 1000
    t.string   "spare5",      :limit => 1000
    t.datetime "spare6"
  end

  add_index "tab$", ["bobj#"], :name => "i_tab1"

  create_table "tab_stats$", :id => false, :force => true do |t|
    t.decimal  "obj#",                        :null => false
    t.decimal  "cachedblk"
    t.decimal  "cachehit"
    t.decimal  "logicalread"
    t.decimal  "rowcnt"
    t.decimal  "blkcnt"
    t.decimal  "empcnt"
    t.decimal  "avgspc"
    t.decimal  "chncnt"
    t.decimal  "avgrln"
    t.decimal  "avgspc_flb"
    t.decimal  "flbcnt"
    t.datetime "analyzetime"
    t.decimal  "samplesize"
    t.decimal  "flags"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",      :limit => 1000
    t.string   "spare5",      :limit => 1000
    t.datetime "spare6"
  end

  add_index "tab_stats$", ["obj#"], :name => "i_tab_stats$_obj#", :unique => true

# Could not dump table "tabcompart$" because of following StandardError
#   Unknown type 'LONG' for column 'hiboundval'

  create_table "table_privilege_map", :id => false, :force => true do |t|
    t.decimal "privilege",               :null => false
    t.string  "name",      :limit => 40, :null => false
  end

  add_index "table_privilege_map", ["privilege", "name"], :name => "i_table_privilege_map", :unique => true

# Could not dump table "tabpart$" because of following StandardError
#   Unknown type 'LONG' for column 'hiboundval'

# Could not dump table "tabsubpart$" because of following StandardError
#   Unknown type 'LONG' for column 'hiboundval'

  create_table "transformations$", :primary_key => "transformation_id", :force => true do |t|
    t.string  "owner",        :limit => 30, :null => false
    t.string  "name",         :limit => 30, :null => false
    t.string  "from_schema",  :limit => 30
    t.string  "from_type",    :limit => 30
    t.raw     "from_toid",    :limit => 16, :null => false
    t.decimal "from_version",               :null => false
    t.string  "to_schema",    :limit => 30
    t.string  "to_type",      :limit => 60
    t.raw     "to_toid",      :limit => 16, :null => false
    t.decimal "to_version",                 :null => false
  end

# Could not dump table "trigger$" because of following StandardError
#   Unknown type 'LONG' for column 'action#'

  create_table "triggercol$", :id => false, :force => true do |t|
    t.decimal "obj#",      :null => false
    t.decimal "col#",      :null => false
    t.decimal "type#",     :null => false
    t.decimal "position#"
    t.decimal "intcol#",   :null => false
  end

  add_index "triggercol$", ["obj#", "col#", "type#", "position#"], :name => "i_triggercol1"
  add_index "triggercol$", ["obj#", "intcol#", "type#", "position#"], :name => "i_triggercol2"

# Could not dump table "triggerjavac$" because of following StandardError
#   Unknown type 'LONG' for column 'classname'

  create_table "triggerjavaf$", :id => false, :force => true do |t|
    t.decimal "obj#",                      :null => false
    t.raw     "flags",      :limit => nil
    t.decimal "flaglength"
  end

  add_index "triggerjavaf$", ["obj#"], :name => "i_triggerjavaf", :unique => true

# Could not dump table "triggerjavam$" because of following StandardError
#   Unknown type 'LONG' for column 'methodname'

# Could not dump table "triggerjavas$" because of following StandardError
#   Unknown type 'LONG' for column 'signature'

  create_table "trusted_list$", :id => false, :force => true do |t|
    t.string "dbname",   :limit => 128,  :null => false
    t.string "username", :limit => 4000, :null => false
  end

  create_table "ts$", :id => false, :force => true do |t|
    t.decimal  "ts#",                           :null => false
    t.string   "name",          :limit => 30,   :null => false
    t.decimal  "owner#",                        :null => false
    t.decimal  "online$",                       :null => false
    t.decimal  "contents$",                     :null => false
    t.decimal  "undofile#"
    t.decimal  "undoblock#"
    t.decimal  "blocksize",                     :null => false
    t.decimal  "inc#",                          :null => false
    t.decimal  "scnwrp"
    t.decimal  "scnbas"
    t.decimal  "dflminext",                     :null => false
    t.decimal  "dflmaxext",                     :null => false
    t.decimal  "dflinit",                       :null => false
    t.decimal  "dflincr",                       :null => false
    t.decimal  "dflminlen",                     :null => false
    t.decimal  "dflextpct",                     :null => false
    t.decimal  "dflogging",                     :null => false
    t.decimal  "affstrength",                   :null => false
    t.decimal  "bitmapped",                     :null => false
    t.decimal  "plugged",                       :null => false
    t.decimal  "directallowed",                 :null => false
    t.decimal  "flags",                         :null => false
    t.decimal  "pitrscnwrp"
    t.decimal  "pitrscnbas"
    t.string   "ownerinstance", :limit => 30
    t.string   "backupowner",   :limit => 30
    t.string   "groupname",     :limit => 30
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.string   "spare3",        :limit => 1000
    t.datetime "spare4"
  end

  add_index "ts$", ["name"], :name => "i_ts1", :unique => true

  create_table "tsm_dst$", :id => false, :force => true do |t|
    t.string    "src_db_name",         :limit => 4000
    t.string    "dst_db_name",         :limit => 4000
    t.string    "dst_inst_name",       :limit => 4000
    t.string    "dst_inst_id",         :limit => 4000
    t.timestamp "dst_inst_start_time", :limit => 6
    t.decimal   "sequence#"
    t.decimal   "dst_sid"
    t.decimal   "dst_serial#"
    t.timestamp "dst_start_time",      :limit => 6
    t.timestamp "dst_end_time",        :limit => 6
    t.decimal   "dst_userid"
    t.decimal   "dst_schemaid"
    t.decimal   "dst_state"
  end

  add_index "tsm_dst$", ["dst_sid", "dst_serial#", "sequence#"], :name => "i_tsm_dst2$", :tablespace => "sysaux"
  add_index "tsm_dst$", ["sequence#"], :name => "i_tsm_dst1$", :tablespace => "sysaux"

  create_table "tsm_src$", :id => false, :force => true do |t|
    t.string    "src_db_name",         :limit => 4000
    t.string    "src_inst_name",       :limit => 4000
    t.string    "src_inst_id",         :limit => 4000
    t.timestamp "src_inst_start_time", :limit => 6
    t.decimal   "sequence#"
    t.decimal   "src_sid"
    t.decimal   "src_serial#"
    t.decimal   "src_state"
    t.string    "connect_string",      :limit => 4000
    t.timestamp "src_start_time",      :limit => 6
    t.decimal   "cost"
    t.decimal   "failure_reason"
    t.timestamp "src_end_time",        :limit => 6
    t.decimal   "roundtrips"
    t.decimal   "src_userid"
    t.decimal   "src_schemaid"
    t.string    "dst_db_name",         :limit => 4000
  end

  add_index "tsm_src$", ["sequence#"], :name => "i_tsm_src1$", :tablespace => "sysaux"
  add_index "tsm_src$", ["src_sid", "src_serial#", "sequence#"], :name => "i_tsm_src2$", :tablespace => "sysaux"

  create_table "tsq$", :id => false, :force => true do |t|
    t.decimal "ts#",       :null => false
    t.decimal "user#",     :null => false
    t.decimal "grantor#",  :null => false
    t.decimal "blocks",    :null => false
    t.decimal "maxblocks"
    t.decimal "priv1",     :null => false
    t.decimal "priv2",     :null => false
    t.decimal "priv3",     :null => false
  end

  create_table "type$", :id => false, :force => true do |t|
    t.raw     "toid",            :limit => 16,   :null => false
    t.decimal "version#",                        :null => false
    t.string  "version",         :limit => 30,   :null => false
    t.raw     "tvoid",           :limit => 16,   :null => false
    t.decimal "typecode",                        :null => false
    t.decimal "properties",                      :null => false
    t.decimal "attributes"
    t.decimal "methods"
    t.decimal "hiddenmethods"
    t.decimal "supertypes"
    t.decimal "subtypes"
    t.decimal "externtype"
    t.string  "externname",      :limit => 4000
    t.string  "helperclassname", :limit => 4000
    t.decimal "local_attrs"
    t.decimal "local_methods"
    t.raw     "typeid",          :limit => 16
    t.raw     "roottoid",        :limit => 16
    t.decimal "spare1"
    t.decimal "spare2"
    t.decimal "spare3"
    t.raw     "supertoid",       :limit => 16
    t.raw     "hashcode",        :limit => 17
  end

  add_index "type$", ["hashcode"], :name => "i_type5"
  add_index "type$", ["roottoid"], :name => "i_type3"
  add_index "type$", ["supertoid"], :name => "i_type4"
  add_index "type$", ["toid", "version"], :name => "i_type1", :unique => true
  add_index "type$", ["tvoid"], :name => "i_type2", :unique => true

  create_table "type_misc$", :id => false, :force => true do |t|
    t.decimal "obj#",                     :null => false
    t.string  "audit$",     :limit => 38, :null => false
    t.decimal "properties",               :null => false
  end

# Could not dump table "typed_view$" because of following StandardError
#   Unknown type 'LONG' for column 'transtext'

  create_table "typehierarchy$", :id => false, :force => true do |t|
    t.raw     "toid",        :limit => 16, :null => false
    t.raw     "next_typeid", :limit => 16, :null => false
    t.decimal "spare1"
    t.decimal "spare2"
  end

  add_index "typehierarchy$", ["toid"], :name => "i_typehierarchy1", :unique => true

  create_table "uet$", :id => false, :force => true do |t|
    t.decimal "segfile#",  :null => false
    t.decimal "segblock#", :null => false
    t.decimal "ext#",      :null => false
    t.decimal "ts#",       :null => false
    t.decimal "file#",     :null => false
    t.decimal "block#",    :null => false
    t.decimal "length",    :null => false
  end

  create_table "ugroup$", :id => false, :force => true do |t|
    t.decimal "ugrp#",                :null => false
    t.string  "name",   :limit => 30, :null => false
    t.decimal "seq#"
    t.decimal "spare1"
    t.string  "spare2", :limit => 30
    t.decimal "spare3"
  end

  add_index "ugroup$", ["name"], :name => "i_ugroup1"
  add_index "ugroup$", ["ugrp#"], :name => "i_ugroup2"

  create_table "undo$", :id => false, :force => true do |t|
    t.decimal  "us#",                     :null => false
    t.string   "name",    :limit => 30,   :null => false
    t.decimal  "user#",                   :null => false
    t.decimal  "file#",                   :null => false
    t.decimal  "block#",                  :null => false
    t.decimal  "scnbas"
    t.decimal  "scnwrp"
    t.decimal  "xactsqn"
    t.decimal  "undosqn"
    t.decimal  "inst#"
    t.decimal  "status$",                 :null => false
    t.decimal  "ts#"
    t.decimal  "ugrp#"
    t.decimal  "keep"
    t.decimal  "optimal"
    t.decimal  "flags"
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",  :limit => 1000
    t.string   "spare5",  :limit => 1000
    t.datetime "spare6"
  end

  add_index "undo$", ["name"], :name => "i_undo2"
  add_index "undo$", ["us#"], :name => "i_undo1", :unique => true

  create_table "user$", :id => false, :force => true do |t|
    t.decimal  "user#",                                         :null => false
    t.string   "name",         :limit => 30,                    :null => false
    t.decimal  "type#",                                         :null => false
    t.string   "password",     :limit => 30
    t.decimal  "datats#",                                       :null => false
    t.decimal  "tempts#",                                       :null => false
    t.datetime "ctime",                                         :null => false
    t.datetime "ptime"
    t.datetime "exptime"
    t.datetime "ltime"
    t.decimal  "resource$",                                     :null => false
    t.string   "audit$",       :limit => 38
    t.decimal  "defrole",                                       :null => false
    t.decimal  "defgrp#"
    t.decimal  "defgrp_seq#"
    t.decimal  "astatus",                      :default => 0.0, :null => false
    t.decimal  "lcount",                       :default => 0.0, :null => false
    t.string   "defschclass",  :limit => 30
    t.string   "ext_username", :limit => 4000
    t.decimal  "spare1"
    t.decimal  "spare2"
    t.decimal  "spare3"
    t.string   "spare4",       :limit => 1000
    t.string   "spare5",       :limit => 1000
    t.datetime "spare6"
  end

  add_index "user$", ["name"], :name => "i_user1", :unique => true

  create_table "user_astatus_map", :id => false, :force => true do |t|
    t.decimal "status#",               :null => false
    t.string  "status",  :limit => 32, :null => false
  end

  create_table "user_history$", :id => false, :force => true do |t|
    t.decimal  "user#",                       :null => false
    t.string   "password",      :limit => 30
    t.datetime "password_date"
  end

  create_table "ustats$", :id => false, :force => true do |t|
    t.decimal "obj#",       :null => false
    t.decimal "intcol#"
    t.decimal "statstype#"
    t.decimal "property"
    t.raw     "statistics"
    t.decimal "spare1"
    t.decimal "spare2"
  end

  add_index "ustats$", ["obj#", "intcol#"], :name => "ustats1", :unique => true

  create_table "utl_recomp_compiled", :id => false, :force => true do |t|
    t.decimal   "obj#",                      :null => false
    t.decimal   "batch#"
    t.timestamp "compiled_at", :limit => 6
    t.string    "compiled_by", :limit => 64
  end

  create_table "utl_recomp_errors", :id => false, :force => true do |t|
    t.decimal   "obj#"
    t.timestamp "error_at",    :limit => 6
    t.string    "compile_err", :limit => 4000
  end

  create_table "utl_recomp_sorted", :id => false, :force => true do |t|
    t.decimal "obj#",                    :null => false
    t.string  "owner",     :limit => 30
    t.string  "objname",   :limit => 30
    t.decimal "namespace"
    t.decimal "depth"
    t.decimal "batch#"
  end

  add_index "utl_recomp_sorted", ["obj#"], :name => "utl_recomp_sort_idx1", :unique => true

# Could not dump table "view$" because of following StandardError
#   Unknown type 'LONG' for column 'text'

  create_table "viewcon$", :id => false, :force => true do |t|
    t.decimal "obj#",                   :null => false
    t.decimal "con#"
    t.string  "conname",  :limit => 30
    t.decimal "type#"
    t.text    "con_text"
    t.decimal "robj#"
    t.decimal "property"
  end

  add_index "viewcon$", ["obj#"], :name => "i_viewcon1"
  add_index "viewcon$", ["robj#"], :name => "i_viewcon2"

  create_table "viewtrcol$", :id => false, :force => true do |t|
    t.decimal "obj#",                       :null => false
    t.decimal "intcol#",                    :null => false
    t.decimal "attribute#",                 :null => false
    t.string  "name",       :limit => 4000, :null => false
  end

  add_index "viewtrcol$", ["obj#", "intcol#", "attribute#"], :name => "i_viewtrcol1", :unique => true

  create_table "vtable$", :id => false, :force => true do |t|
    t.decimal "obj#",                     :null => false
    t.decimal "vindex",                   :null => false
    t.raw     "itypetoid",  :limit => 16
    t.string  "itypeowner", :limit => 30
    t.string  "itypename",  :limit => 30
    t.decimal "imethod#",                 :null => false
    t.decimal "iflags"
  end

  create_table "warning_settings$", :id => false, :force => true do |t|
    t.decimal "obj#",        :null => false
    t.decimal "warning_num", :null => false
    t.decimal "global_mod"
    t.decimal "property"
  end

  add_index "warning_settings$", ["obj#"], :name => "i_warning_settings"

  create_table "wrh$_active_session_history", :id => false, :force => true do |t|
    t.decimal   "snap_id",                                :null => false
    t.decimal   "dbid",                                   :null => false
    t.decimal   "instance_number",                        :null => false
    t.decimal   "sample_id",                              :null => false
    t.timestamp "sample_time",              :limit => 3,  :null => false
    t.decimal   "session_id",                             :null => false
    t.decimal   "session_serial#"
    t.decimal   "user_id"
    t.string    "sql_id",                   :limit => 13
    t.decimal   "sql_child_number"
    t.decimal   "sql_plan_hash_value"
    t.decimal   "service_hash"
    t.decimal   "session_type"
    t.decimal   "sql_opcode"
    t.decimal   "qc_session_id"
    t.decimal   "qc_instance_id"
    t.decimal   "current_obj#"
    t.decimal   "current_file#"
    t.decimal   "current_block#"
    t.decimal   "seq#"
    t.decimal   "event_id"
    t.decimal   "p1"
    t.decimal   "p2"
    t.decimal   "p3"
    t.decimal   "wait_time"
    t.decimal   "time_waited"
    t.string    "program",                  :limit => 64
    t.string    "module",                   :limit => 48
    t.string    "action",                   :limit => 32
    t.string    "client_id",                :limit => 64
    t.decimal   "force_matching_signature"
    t.decimal   "blocking_session"
    t.decimal   "blocking_session_serial#"
    t.raw       "xid",                      :limit => 8
  end

  create_table "wrh$_active_session_history_bl", :id => false, :force => true do |t|
    t.decimal   "snap_id",                                :null => false
    t.decimal   "dbid",                                   :null => false
    t.decimal   "instance_number",                        :null => false
    t.decimal   "sample_id",                              :null => false
    t.timestamp "sample_time",              :limit => 3,  :null => false
    t.decimal   "session_id",                             :null => false
    t.decimal   "session_serial#"
    t.decimal   "user_id"
    t.string    "sql_id",                   :limit => 13
    t.decimal   "sql_child_number"
    t.decimal   "sql_plan_hash_value"
    t.decimal   "service_hash"
    t.decimal   "session_type"
    t.decimal   "sql_opcode"
    t.decimal   "qc_session_id"
    t.decimal   "qc_instance_id"
    t.decimal   "current_obj#"
    t.decimal   "current_file#"
    t.decimal   "current_block#"
    t.decimal   "seq#"
    t.decimal   "event_id"
    t.decimal   "p1"
    t.decimal   "p2"
    t.decimal   "p3"
    t.decimal   "wait_time"
    t.decimal   "time_waited"
    t.string    "program",                  :limit => 64
    t.string    "module",                   :limit => 48
    t.string    "action",                   :limit => 32
    t.string    "client_id",                :limit => 64
    t.decimal   "force_matching_signature"
    t.decimal   "blocking_session"
    t.decimal   "blocking_session_serial#"
    t.raw       "xid",                      :limit => 8
  end

  create_table "wrh$_bg_event_summary", :id => false, :force => true do |t|
    t.decimal "snap_id",           :null => false
    t.decimal "dbid",              :null => false
    t.decimal "instance_number",   :null => false
    t.decimal "event_id",          :null => false
    t.decimal "total_waits"
    t.decimal "total_timeouts"
    t.decimal "time_waited_micro"
  end

  create_table "wrh$_buffer_pool_statistics", :id => false, :force => true do |t|
    t.decimal "snap_id",                               :null => false
    t.decimal "dbid",                                  :null => false
    t.decimal "instance_number",                       :null => false
    t.decimal "id",                                    :null => false
    t.string  "name",                    :limit => 20
    t.decimal "block_size"
    t.decimal "set_msize"
    t.decimal "cnum_repl"
    t.decimal "cnum_write"
    t.decimal "cnum_set"
    t.decimal "buf_got"
    t.decimal "sum_write"
    t.decimal "sum_scan"
    t.decimal "free_buffer_wait"
    t.decimal "write_complete_wait"
    t.decimal "buffer_busy_wait"
    t.decimal "free_buffer_inspected"
    t.decimal "dirty_buffers_inspected"
    t.decimal "db_block_change"
    t.decimal "db_block_gets"
    t.decimal "consistent_gets"
    t.decimal "physical_reads"
    t.decimal "physical_writes"
  end

  create_table "wrh$_buffered_queues", :id => false, :force => true do |t|
    t.decimal  "snap_id",                       :null => false
    t.decimal  "dbid",                          :null => false
    t.decimal  "instance_number",               :null => false
    t.string   "queue_schema",    :limit => 30, :null => false
    t.string   "queue_name",      :limit => 30, :null => false
    t.datetime "startup_time",                  :null => false
    t.decimal  "queue_id",                      :null => false
    t.decimal  "num_msgs"
    t.decimal  "spill_msgs"
    t.decimal  "cnum_msgs"
    t.decimal  "cspill_msgs"
  end

  create_table "wrh$_buffered_subscribers", :id => false, :force => true do |t|
    t.decimal  "snap_id",                            :null => false
    t.decimal  "dbid",                               :null => false
    t.decimal  "instance_number",                    :null => false
    t.string   "queue_schema",       :limit => 30,   :null => false
    t.string   "queue_name",         :limit => 30,   :null => false
    t.decimal  "subscriber_id",                      :null => false
    t.string   "subscriber_name",    :limit => 30
    t.string   "subscriber_address", :limit => 1024
    t.string   "subscriber_type",    :limit => 30
    t.datetime "startup_time",                       :null => false
    t.decimal  "num_msgs"
    t.decimal  "cnum_msgs"
    t.decimal  "total_spilled_msg"
  end

  create_table "wrh$_comp_iostat", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "component",       :limit => 64, :null => false
    t.string  "file_type",       :limit => 64, :null => false
    t.string  "io_type",         :limit => 5,  :null => false
    t.string  "operation",       :limit => 5,  :null => false
    t.decimal "bytes",                         :null => false
    t.decimal "io_count",                      :null => false
  end

  create_table "wrh$_cr_block_server", :id => false, :force => true do |t|
    t.decimal "snap_id",                :null => false
    t.decimal "dbid",                   :null => false
    t.decimal "instance_number",        :null => false
    t.decimal "cr_requests"
    t.decimal "current_requests"
    t.decimal "data_requests"
    t.decimal "undo_requests"
    t.decimal "tx_requests"
    t.decimal "current_results"
    t.decimal "private_results"
    t.decimal "zero_results"
    t.decimal "disk_read_results"
    t.decimal "fail_results"
    t.decimal "fairness_down_converts"
    t.decimal "fairness_clears"
    t.decimal "free_gc_elements"
    t.decimal "flushes"
    t.decimal "flushes_queued"
    t.decimal "flush_queue_full"
    t.decimal "flush_max_time"
    t.decimal "light_works"
    t.decimal "errors"
  end

  create_table "wrh$_current_block_server", :id => false, :force => true do |t|
    t.decimal "snap_id",         :null => false
    t.decimal "dbid",            :null => false
    t.decimal "instance_number", :null => false
    t.decimal "pin1"
    t.decimal "pin10"
    t.decimal "pin100"
    t.decimal "pin1000"
    t.decimal "pin10000"
    t.decimal "flush1"
    t.decimal "flush10"
    t.decimal "flush100"
    t.decimal "flush1000"
    t.decimal "flush10000"
    t.decimal "write1"
    t.decimal "write10"
    t.decimal "write100"
    t.decimal "write1000"
    t.decimal "write10000"
  end

  create_table "wrh$_datafile", :id => false, :force => true do |t|
    t.decimal "snap_id"
    t.decimal "dbid",                            :null => false
    t.decimal "file#",                           :null => false
    t.decimal "creation_change#",                :null => false
    t.string  "filename",         :limit => 513, :null => false
    t.decimal "ts#",                             :null => false
    t.string  "tsname",           :limit => 30,  :null => false
    t.decimal "block_size"
  end

  create_table "wrh$_db_cache_advice", :id => false, :force => true do |t|
    t.decimal "snap_id",                             :null => false
    t.decimal "dbid",                                :null => false
    t.decimal "instance_number",                     :null => false
    t.decimal "bpid",                                :null => false
    t.decimal "buffers_for_estimate",                :null => false
    t.string  "name",                  :limit => 20
    t.decimal "block_size"
    t.string  "advice_status",         :limit => 3
    t.decimal "size_for_estimate"
    t.decimal "size_factor"
    t.decimal "physical_reads"
    t.decimal "base_physical_reads"
    t.decimal "actual_physical_reads"
  end

  create_table "wrh$_db_cache_advice_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                             :null => false
    t.decimal "dbid",                                :null => false
    t.decimal "instance_number",                     :null => false
    t.decimal "bpid",                                :null => false
    t.decimal "buffers_for_estimate",                :null => false
    t.string  "name",                  :limit => 20
    t.decimal "block_size"
    t.string  "advice_status",         :limit => 3
    t.decimal "size_for_estimate"
    t.decimal "size_factor"
    t.decimal "physical_reads"
    t.decimal "base_physical_reads"
    t.decimal "actual_physical_reads"
  end

  create_table "wrh$_dlm_misc", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.decimal "statistic#",                    :null => false
    t.string  "name",            :limit => 38
    t.decimal "value"
  end

  create_table "wrh$_dlm_misc_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.decimal "statistic#",                    :null => false
    t.string  "name",            :limit => 38
    t.decimal "value"
  end

  create_table "wrh$_enqueue_stat", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "eq_type",         :limit => 2,  :null => false
    t.string  "req_reason",      :limit => 64, :null => false
    t.decimal "total_req#"
    t.decimal "total_wait#"
    t.decimal "succ_req#"
    t.decimal "failed_req#"
    t.decimal "cum_wait_time"
    t.decimal "event#"
  end

  create_table "wrh$_event_name", :id => false, :force => true do |t|
    t.decimal "dbid",                        :null => false
    t.decimal "event_id",                    :null => false
    t.string  "event_name",    :limit => 64, :null => false
    t.string  "parameter1",    :limit => 64
    t.string  "parameter2",    :limit => 64
    t.string  "parameter3",    :limit => 64
    t.decimal "wait_class_id"
    t.string  "wait_class",    :limit => 64
  end

  create_table "wrh$_filemetric_history", :id => false, :force => true do |t|
    t.decimal  "snap_id",         :null => false
    t.decimal  "dbid",            :null => false
    t.decimal  "instance_number", :null => false
    t.decimal  "fileid",          :null => false
    t.decimal  "creationtime",    :null => false
    t.datetime "begin_time",      :null => false
    t.datetime "end_time",        :null => false
    t.decimal  "intsize",         :null => false
    t.decimal  "group_id",        :null => false
    t.decimal  "avgreadtime",     :null => false
    t.decimal  "avgwritetime",    :null => false
    t.decimal  "physicalread",    :null => false
    t.decimal  "physicalwrite",   :null => false
    t.decimal  "phyblkread",      :null => false
    t.decimal  "phyblkwrite",     :null => false
  end

  add_index "wrh$_filemetric_history", ["dbid", "snap_id", "instance_number", "group_id", "fileid", "begin_time"], :name => "wrh$_filemetric_history_index", :tablespace => "sysaux"

  create_table "wrh$_filestatxs", :id => false, :force => true do |t|
    t.decimal "snap_id",          :null => false
    t.decimal "dbid",             :null => false
    t.decimal "instance_number",  :null => false
    t.decimal "file#",            :null => false
    t.decimal "creation_change#", :null => false
    t.decimal "phyrds"
    t.decimal "phywrts"
    t.decimal "singleblkrds"
    t.decimal "readtim"
    t.decimal "writetim"
    t.decimal "singleblkrdtim"
    t.decimal "phyblkrd"
    t.decimal "phyblkwrt"
    t.decimal "wait_count"
    t.decimal "time"
  end

  create_table "wrh$_filestatxs_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",          :null => false
    t.decimal "dbid",             :null => false
    t.decimal "instance_number",  :null => false
    t.decimal "file#",            :null => false
    t.decimal "creation_change#", :null => false
    t.decimal "phyrds"
    t.decimal "phywrts"
    t.decimal "singleblkrds"
    t.decimal "readtim"
    t.decimal "writetim"
    t.decimal "singleblkrdtim"
    t.decimal "phyblkrd"
    t.decimal "phyblkwrt"
    t.decimal "wait_count"
    t.decimal "time"
  end

  create_table "wrh$_inst_cache_transfer", :id => false, :force => true do |t|
    t.decimal "snap_id",                         :null => false
    t.decimal "dbid",                            :null => false
    t.decimal "instance_number",                 :null => false
    t.decimal "instance",                        :null => false
    t.string  "class",             :limit => 18, :null => false
    t.decimal "cr_block"
    t.decimal "cr_busy"
    t.decimal "cr_congested"
    t.decimal "current_block"
    t.decimal "current_busy"
    t.decimal "current_congested"
  end

  create_table "wrh$_inst_cache_transfer_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                         :null => false
    t.decimal "dbid",                            :null => false
    t.decimal "instance_number",                 :null => false
    t.decimal "instance",                        :null => false
    t.string  "class",             :limit => 18, :null => false
    t.decimal "cr_block"
    t.decimal "cr_busy"
    t.decimal "cr_congested"
    t.decimal "current_block"
    t.decimal "current_busy"
    t.decimal "current_congested"
  end

  create_table "wrh$_instance_recovery", :id => false, :force => true do |t|
    t.decimal "snap_id",                        :null => false
    t.decimal "dbid",                           :null => false
    t.decimal "instance_number",                :null => false
    t.decimal "recovery_estimated_ios"
    t.decimal "actual_redo_blks"
    t.decimal "target_redo_blks"
    t.decimal "log_file_size_redo_blks"
    t.decimal "log_chkpt_timeout_redo_blks"
    t.decimal "log_chkpt_interval_redo_blks"
    t.decimal "fast_start_io_target_redo_blks"
    t.decimal "target_mttr"
    t.decimal "estimated_mttr"
    t.decimal "ckpt_block_writes"
    t.decimal "optimal_logfile_size"
    t.decimal "estd_cluster_available_time"
    t.decimal "writes_mttr"
    t.decimal "writes_logfile_size"
    t.decimal "writes_log_checkpoint_settings"
    t.decimal "writes_other_settings"
    t.decimal "writes_autotune"
    t.decimal "writes_full_thread_ckpt"
  end

  create_table "wrh$_java_pool_advice", :id => false, :force => true do |t|
    t.decimal "snap_id",                     :null => false
    t.decimal "dbid",                        :null => false
    t.decimal "instance_number",             :null => false
    t.decimal "java_pool_size_for_estimate", :null => false
    t.decimal "java_pool_size_factor"
    t.decimal "estd_lc_size"
    t.decimal "estd_lc_memory_objects"
    t.decimal "estd_lc_time_saved"
    t.decimal "estd_lc_time_saved_factor"
    t.decimal "estd_lc_load_time"
    t.decimal "estd_lc_load_time_factor"
    t.decimal "estd_lc_memory_object_hits"
  end

  create_table "wrh$_latch", :id => false, :force => true do |t|
    t.decimal "snap_id",          :null => false
    t.decimal "dbid",             :null => false
    t.decimal "instance_number",  :null => false
    t.decimal "latch_hash",       :null => false
    t.decimal "level#"
    t.decimal "gets"
    t.decimal "misses"
    t.decimal "sleeps"
    t.decimal "immediate_gets"
    t.decimal "immediate_misses"
    t.decimal "spin_gets"
    t.decimal "sleep1"
    t.decimal "sleep2"
    t.decimal "sleep3"
    t.decimal "sleep4"
    t.decimal "wait_time"
  end

  create_table "wrh$_latch_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",          :null => false
    t.decimal "dbid",             :null => false
    t.decimal "instance_number",  :null => false
    t.decimal "latch_hash",       :null => false
    t.decimal "level#"
    t.decimal "gets"
    t.decimal "misses"
    t.decimal "sleeps"
    t.decimal "immediate_gets"
    t.decimal "immediate_misses"
    t.decimal "spin_gets"
    t.decimal "sleep1"
    t.decimal "sleep2"
    t.decimal "sleep3"
    t.decimal "sleep4"
    t.decimal "wait_time"
  end

  create_table "wrh$_latch_children", :id => false, :force => true do |t|
    t.decimal "snap_id",          :null => false
    t.decimal "dbid",             :null => false
    t.decimal "instance_number",  :null => false
    t.decimal "latch_hash",       :null => false
    t.decimal "child#",           :null => false
    t.decimal "gets"
    t.decimal "misses"
    t.decimal "sleeps"
    t.decimal "immediate_gets"
    t.decimal "immediate_misses"
    t.decimal "spin_gets"
    t.decimal "sleep1"
    t.decimal "sleep2"
    t.decimal "sleep3"
    t.decimal "sleep4"
    t.decimal "wait_time"
  end

  create_table "wrh$_latch_children_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",          :null => false
    t.decimal "dbid",             :null => false
    t.decimal "instance_number",  :null => false
    t.decimal "latch_hash",       :null => false
    t.decimal "child#",           :null => false
    t.decimal "gets"
    t.decimal "misses"
    t.decimal "sleeps"
    t.decimal "immediate_gets"
    t.decimal "immediate_misses"
    t.decimal "spin_gets"
    t.decimal "sleep1"
    t.decimal "sleep2"
    t.decimal "sleep3"
    t.decimal "sleep4"
    t.decimal "wait_time"
  end

  create_table "wrh$_latch_misses_summary", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "parent_name",     :limit => 50, :null => false
    t.string  "where_in_code",   :limit => 64, :null => false
    t.decimal "nwfail_count"
    t.decimal "sleep_count"
    t.decimal "wtr_slp_count"
  end

  create_table "wrh$_latch_misses_summary_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "parent_name",     :limit => 50, :null => false
    t.string  "where_in_code",   :limit => 64, :null => false
    t.decimal "nwfail_count"
    t.decimal "sleep_count"
    t.decimal "wtr_slp_count"
  end

  create_table "wrh$_latch_name", :id => false, :force => true do |t|
    t.decimal "dbid",                     :null => false
    t.decimal "latch_hash",               :null => false
    t.string  "latch_name", :limit => 64, :null => false
    t.decimal "latch#"
  end

  create_table "wrh$_latch_parent", :id => false, :force => true do |t|
    t.decimal "snap_id",          :null => false
    t.decimal "dbid",             :null => false
    t.decimal "instance_number",  :null => false
    t.decimal "latch_hash",       :null => false
    t.decimal "level#",           :null => false
    t.decimal "gets"
    t.decimal "misses"
    t.decimal "sleeps"
    t.decimal "immediate_gets"
    t.decimal "immediate_misses"
    t.decimal "spin_gets"
    t.decimal "sleep1"
    t.decimal "sleep2"
    t.decimal "sleep3"
    t.decimal "sleep4"
    t.decimal "wait_time"
  end

  create_table "wrh$_latch_parent_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",          :null => false
    t.decimal "dbid",             :null => false
    t.decimal "instance_number",  :null => false
    t.decimal "latch_hash",       :null => false
    t.decimal "level#",           :null => false
    t.decimal "gets"
    t.decimal "misses"
    t.decimal "sleeps"
    t.decimal "immediate_gets"
    t.decimal "immediate_misses"
    t.decimal "spin_gets"
    t.decimal "sleep1"
    t.decimal "sleep2"
    t.decimal "sleep3"
    t.decimal "sleep4"
    t.decimal "wait_time"
  end

  create_table "wrh$_librarycache", :id => false, :force => true do |t|
    t.decimal "snap_id",                                 :null => false
    t.decimal "dbid",                                    :null => false
    t.decimal "instance_number",                         :null => false
    t.string  "namespace",                 :limit => 15, :null => false
    t.decimal "gets"
    t.decimal "gethits"
    t.decimal "pins"
    t.decimal "pinhits"
    t.decimal "reloads"
    t.decimal "invalidations"
    t.decimal "dlm_lock_requests"
    t.decimal "dlm_pin_requests"
    t.decimal "dlm_pin_releases"
    t.decimal "dlm_invalidation_requests"
    t.decimal "dlm_invalidations"
  end

  create_table "wrh$_log", :id => false, :force => true do |t|
    t.decimal  "snap_id",                       :null => false
    t.decimal  "dbid",                          :null => false
    t.decimal  "instance_number",               :null => false
    t.decimal  "group#",                        :null => false
    t.decimal  "thread#",                       :null => false
    t.decimal  "sequence#",                     :null => false
    t.decimal  "bytes"
    t.decimal  "members"
    t.string   "archived",        :limit => 3
    t.string   "status",          :limit => 16
    t.decimal  "first_change#"
    t.datetime "first_time"
  end

  create_table "wrh$_metric_name", :id => false, :force => true do |t|
    t.decimal "dbid",                      :null => false
    t.decimal "group_id",                  :null => false
    t.string  "group_name",  :limit => 64
    t.decimal "metric_id",                 :null => false
    t.string  "metric_name", :limit => 64, :null => false
    t.string  "metric_unit", :limit => 64, :null => false
  end

  create_table "wrh$_mttr_target_advice", :id => false, :force => true do |t|
    t.decimal "snap_id",                               :null => false
    t.decimal "dbid",                                  :null => false
    t.decimal "instance_number",                       :null => false
    t.decimal "mttr_target_for_estimate"
    t.string  "advice_status",            :limit => 5
    t.decimal "dirty_limit"
    t.decimal "estd_cache_writes"
    t.decimal "estd_cache_write_factor"
    t.decimal "estd_total_writes"
    t.decimal "estd_total_write_factor"
    t.decimal "estd_total_ios"
    t.decimal "estd_total_io_factor"
  end

  create_table "wrh$_optimizer_env", :id => false, :force => true do |t|
    t.decimal "snap_id"
    t.decimal "dbid",                                     :null => false
    t.decimal "optimizer_env_hash_value",                 :null => false
    t.raw     "optimizer_env",            :limit => 1000
  end

  create_table "wrh$_osstat", :id => false, :force => true do |t|
    t.decimal "snap_id",         :null => false
    t.decimal "dbid",            :null => false
    t.decimal "instance_number", :null => false
    t.decimal "stat_id",         :null => false
    t.decimal "value"
  end

  create_table "wrh$_osstat_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",         :null => false
    t.decimal "dbid",            :null => false
    t.decimal "instance_number", :null => false
    t.decimal "stat_id",         :null => false
    t.decimal "value"
  end

  create_table "wrh$_osstat_name", :id => false, :force => true do |t|
    t.decimal "dbid",                    :null => false
    t.decimal "stat_id",                 :null => false
    t.string  "stat_name", :limit => 64, :null => false
  end

  create_table "wrh$_parameter", :id => false, :force => true do |t|
    t.decimal "snap_id",                        :null => false
    t.decimal "dbid",                           :null => false
    t.decimal "instance_number",                :null => false
    t.decimal "parameter_hash",                 :null => false
    t.string  "value",           :limit => 512
    t.string  "isdefault",       :limit => 9
    t.string  "ismodified",      :limit => 10
  end

  create_table "wrh$_parameter_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                        :null => false
    t.decimal "dbid",                           :null => false
    t.decimal "instance_number",                :null => false
    t.decimal "parameter_hash",                 :null => false
    t.string  "value",           :limit => 512
    t.string  "isdefault",       :limit => 9
    t.string  "ismodified",      :limit => 10
  end

  create_table "wrh$_parameter_name", :id => false, :force => true do |t|
    t.decimal "dbid",                         :null => false
    t.decimal "parameter_hash",               :null => false
    t.string  "parameter_name", :limit => 64, :null => false
  end

  create_table "wrh$_pga_target_advice", :id => false, :force => true do |t|
    t.decimal "snap_id",                                    :null => false
    t.decimal "dbid",                                       :null => false
    t.decimal "instance_number",                            :null => false
    t.decimal "pga_target_for_estimate",                    :null => false
    t.decimal "pga_target_factor"
    t.string  "advice_status",                 :limit => 3
    t.decimal "bytes_processed"
    t.decimal "estd_extra_bytes_rw"
    t.decimal "estd_pga_cache_hit_percentage"
    t.decimal "estd_overalloc_count"
  end

  create_table "wrh$_pgastat", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "name",            :limit => 64, :null => false
    t.decimal "value"
  end

  create_table "wrh$_process_memory_summary", :id => false, :force => true do |t|
    t.decimal "snap_id",                         :null => false
    t.decimal "dbid",                            :null => false
    t.decimal "instance_number",                 :null => false
    t.string  "category",          :limit => 15, :null => false
    t.decimal "num_processes"
    t.decimal "non_zero_allocs"
    t.decimal "used_total"
    t.decimal "allocated_total"
    t.decimal "allocated_stddev"
    t.decimal "allocated_max"
    t.decimal "max_allocated_max"
  end

  create_table "wrh$_resource_limit", :id => false, :force => true do |t|
    t.decimal "snap_id",                           :null => false
    t.decimal "dbid",                              :null => false
    t.decimal "instance_number",                   :null => false
    t.string  "resource_name",       :limit => 30, :null => false
    t.decimal "current_utilization"
    t.decimal "max_utilization"
    t.string  "initial_allocation",  :limit => 10
    t.string  "limit_value",         :limit => 10
  end

  create_table "wrh$_rowcache_summary", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "parameter",       :limit => 32, :null => false
    t.decimal "total_usage"
    t.decimal "usage"
    t.decimal "gets"
    t.decimal "getmisses"
    t.decimal "scans"
    t.decimal "scanmisses"
    t.decimal "scancompletes"
    t.decimal "modifications"
    t.decimal "flushes"
    t.decimal "dlm_requests"
    t.decimal "dlm_conflicts"
    t.decimal "dlm_releases"
  end

  create_table "wrh$_rowcache_summary_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "parameter",       :limit => 32, :null => false
    t.decimal "total_usage"
    t.decimal "usage"
    t.decimal "gets"
    t.decimal "getmisses"
    t.decimal "scans"
    t.decimal "scanmisses"
    t.decimal "scancompletes"
    t.decimal "modifications"
    t.decimal "flushes"
    t.decimal "dlm_requests"
    t.decimal "dlm_conflicts"
    t.decimal "dlm_releases"
  end

  create_table "wrh$_rule_set", :id => false, :force => true do |t|
    t.decimal  "snap_id",                            :null => false
    t.decimal  "dbid",                               :null => false
    t.decimal  "instance_number",                    :null => false
    t.string   "owner",                :limit => 30, :null => false
    t.string   "name",                 :limit => 30, :null => false
    t.datetime "startup_time",                       :null => false
    t.decimal  "cpu_time"
    t.decimal  "elapsed_time"
    t.decimal  "evaluations"
    t.decimal  "sql_free_evaluations"
    t.decimal  "sql_executions"
    t.decimal  "reloads"
  end

  create_table "wrh$_seg_stat", :id => false, :force => true do |t|
    t.decimal "snap_id",                      :null => false
    t.decimal "dbid",                         :null => false
    t.decimal "instance_number",              :null => false
    t.decimal "ts#"
    t.decimal "obj#",                         :null => false
    t.decimal "dataobj#",                     :null => false
    t.decimal "logical_reads_total"
    t.decimal "logical_reads_delta"
    t.decimal "buffer_busy_waits_total"
    t.decimal "buffer_busy_waits_delta"
    t.decimal "db_block_changes_total"
    t.decimal "db_block_changes_delta"
    t.decimal "physical_reads_total"
    t.decimal "physical_reads_delta"
    t.decimal "physical_writes_total"
    t.decimal "physical_writes_delta"
    t.decimal "physical_reads_direct_total"
    t.decimal "physical_reads_direct_delta"
    t.decimal "physical_writes_direct_total"
    t.decimal "physical_writes_direct_delta"
    t.decimal "itl_waits_total"
    t.decimal "itl_waits_delta"
    t.decimal "row_lock_waits_total"
    t.decimal "row_lock_waits_delta"
    t.decimal "gc_buffer_busy_total"
    t.decimal "gc_buffer_busy_delta"
    t.decimal "gc_cr_blocks_received_total"
    t.decimal "gc_cr_blocks_received_delta"
    t.decimal "gc_cu_blocks_received_total"
    t.decimal "gc_cu_blocks_received_delta"
    t.decimal "space_used_total"
    t.decimal "space_used_delta"
    t.decimal "space_allocated_total"
    t.decimal "space_allocated_delta"
    t.decimal "table_scans_total"
    t.decimal "table_scans_delta"
    t.decimal "chain_row_excess_total"
    t.decimal "chain_row_excess_delta"
  end

  create_table "wrh$_seg_stat_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                      :null => false
    t.decimal "dbid",                         :null => false
    t.decimal "instance_number",              :null => false
    t.decimal "ts#"
    t.decimal "obj#",                         :null => false
    t.decimal "dataobj#",                     :null => false
    t.decimal "logical_reads_total"
    t.decimal "logical_reads_delta"
    t.decimal "buffer_busy_waits_total"
    t.decimal "buffer_busy_waits_delta"
    t.decimal "db_block_changes_total"
    t.decimal "db_block_changes_delta"
    t.decimal "physical_reads_total"
    t.decimal "physical_reads_delta"
    t.decimal "physical_writes_total"
    t.decimal "physical_writes_delta"
    t.decimal "physical_reads_direct_total"
    t.decimal "physical_reads_direct_delta"
    t.decimal "physical_writes_direct_total"
    t.decimal "physical_writes_direct_delta"
    t.decimal "itl_waits_total"
    t.decimal "itl_waits_delta"
    t.decimal "row_lock_waits_total"
    t.decimal "row_lock_waits_delta"
    t.decimal "gc_buffer_busy_total"
    t.decimal "gc_buffer_busy_delta"
    t.decimal "gc_cr_blocks_received_total"
    t.decimal "gc_cr_blocks_received_delta"
    t.decimal "gc_cu_blocks_received_total"
    t.decimal "gc_cu_blocks_received_delta"
    t.decimal "space_used_total"
    t.decimal "space_used_delta"
    t.decimal "space_allocated_total"
    t.decimal "space_allocated_delta"
    t.decimal "table_scans_total"
    t.decimal "table_scans_delta"
    t.decimal "chain_row_excess_total"
    t.decimal "chain_row_excess_delta"
  end

  create_table "wrh$_seg_stat_obj", :id => false, :force => true do |t|
    t.decimal "snap_id"
    t.decimal "dbid",                            :null => false
    t.decimal "ts#"
    t.decimal "obj#",                            :null => false
    t.decimal "dataobj#",                        :null => false
    t.string  "owner",             :limit => 30, :null => false
    t.string  "object_name",       :limit => 30, :null => false
    t.string  "subobject_name",    :limit => 30
    t.string  "partition_type",    :limit => 8
    t.string  "object_type",       :limit => 18
    t.string  "tablespace_name",   :limit => 30, :null => false
    t.string  "index_type",        :limit => 27
    t.decimal "base_obj#"
    t.string  "base_object_name",  :limit => 30
    t.string  "base_object_owner", :limit => 30
  end

  create_table "wrh$_service_name", :id => false, :force => true do |t|
    t.decimal "snap_id"
    t.decimal "dbid",                            :null => false
    t.decimal "service_name_hash",               :null => false
    t.string  "service_name",      :limit => 64, :null => false
  end

  create_table "wrh$_service_stat", :id => false, :force => true do |t|
    t.decimal "snap_id",           :null => false
    t.decimal "dbid",              :null => false
    t.decimal "instance_number",   :null => false
    t.decimal "service_name_hash", :null => false
    t.decimal "stat_id",           :null => false
    t.decimal "value"
  end

  create_table "wrh$_service_stat_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",           :null => false
    t.decimal "dbid",              :null => false
    t.decimal "instance_number",   :null => false
    t.decimal "service_name_hash", :null => false
    t.decimal "stat_id",           :null => false
    t.decimal "value"
  end

  create_table "wrh$_service_wait_class", :id => false, :force => true do |t|
    t.decimal "snap_id",                         :null => false
    t.decimal "dbid",                            :null => false
    t.decimal "instance_number",                 :null => false
    t.decimal "service_name_hash",               :null => false
    t.decimal "wait_class_id",                   :null => false
    t.string  "wait_class",        :limit => 64
    t.decimal "total_waits"
    t.decimal "time_waited"
  end

  create_table "wrh$_service_wait_class_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                         :null => false
    t.decimal "dbid",                            :null => false
    t.decimal "instance_number",                 :null => false
    t.decimal "service_name_hash",               :null => false
    t.decimal "wait_class_id",                   :null => false
    t.string  "wait_class",        :limit => 64
    t.decimal "total_waits"
    t.decimal "time_waited"
  end

  create_table "wrh$_sess_time_stats", :id => false, :force => true do |t|
    t.decimal  "snap_id",                        :null => false
    t.decimal  "dbid",                           :null => false
    t.decimal  "instance_number",                :null => false
    t.string   "session_type",     :limit => 64, :null => false
    t.datetime "min_logon_time"
    t.decimal  "sum_cpu_time"
    t.decimal  "sum_sys_io_wait"
    t.decimal  "sum_user_io_wait"
  end

  create_table "wrh$_sessmetric_history", :id => false, :force => true do |t|
    t.decimal  "snap_id",         :null => false
    t.decimal  "dbid",            :null => false
    t.decimal  "instance_number", :null => false
    t.datetime "begin_time",      :null => false
    t.datetime "end_time",        :null => false
    t.decimal  "sessid",          :null => false
    t.decimal  "serial#",         :null => false
    t.decimal  "intsize",         :null => false
    t.decimal  "group_id",        :null => false
    t.decimal  "metric_id",       :null => false
    t.decimal  "value",           :null => false
  end

  add_index "wrh$_sessmetric_history", ["dbid", "snap_id", "instance_number", "group_id", "sessid", "metric_id", "begin_time"], :name => "wrh$_sessmetric_history_index", :tablespace => "sysaux"

  create_table "wrh$_sga", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "name",            :limit => 64, :null => false
    t.decimal "value",                         :null => false
  end

  create_table "wrh$_sga_target_advice", :id => false, :force => true do |t|
    t.decimal "snap_id",             :null => false
    t.decimal "dbid",                :null => false
    t.decimal "instance_number",     :null => false
    t.decimal "sga_size",            :null => false
    t.decimal "sga_size_factor",     :null => false
    t.decimal "estd_db_time",        :null => false
    t.decimal "estd_physical_reads"
  end

  create_table "wrh$_sgastat", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "name",            :limit => 64
    t.string  "pool",            :limit => 12
    t.decimal "bytes"
  end

  add_index "wrh$_sgastat", ["dbid", "snap_id", "instance_number", "name", "pool"], :name => "wrh$_sgastat_u", :unique => true

  create_table "wrh$_sgastat_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "name",            :limit => 64
    t.string  "pool",            :limit => 12
    t.decimal "bytes"
  end

  add_index "wrh$_sgastat_bl", ["dbid", "snap_id", "instance_number", "name", "pool"], :name => "wrh$_sgastat_bl_u", :unique => true, :tablespace => "sysaux"

  create_table "wrh$_shared_pool_advice", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.decimal "shared_pool_size_for_estimate", :null => false
    t.decimal "shared_pool_size_factor"
    t.decimal "estd_lc_size"
    t.decimal "estd_lc_memory_objects"
    t.decimal "estd_lc_time_saved"
    t.decimal "estd_lc_time_saved_factor"
    t.decimal "estd_lc_load_time"
    t.decimal "estd_lc_load_time_factor"
    t.decimal "estd_lc_memory_object_hits"
  end

  create_table "wrh$_sql_bind_metadata", :id => false, :force => true do |t|
    t.decimal "snap_id"
    t.decimal "dbid",                          :null => false
    t.string  "sql_id",          :limit => 13, :null => false
    t.string  "name",            :limit => 30
    t.decimal "position",                      :null => false
    t.decimal "dup_position"
    t.decimal "datatype"
    t.string  "datatype_string", :limit => 15
    t.decimal "character_sid"
    t.decimal "precision"
    t.decimal "scale"
    t.decimal "max_length"
  end

  create_table "wrh$_sql_plan", :id => false, :force => true do |t|
    t.decimal  "snap_id"
    t.decimal  "dbid",                              :null => false
    t.string   "sql_id",            :limit => 13,   :null => false
    t.decimal  "plan_hash_value",                   :null => false
    t.decimal  "id",                                :null => false
    t.string   "operation",         :limit => 30
    t.string   "options",           :limit => 30
    t.string   "object_node",       :limit => 128
    t.decimal  "object#"
    t.string   "object_owner",      :limit => 30
    t.string   "object_name",       :limit => 31
    t.string   "object_alias",      :limit => 65
    t.string   "object_type",       :limit => 20
    t.string   "optimizer",         :limit => 20
    t.decimal  "parent_id"
    t.decimal  "depth"
    t.decimal  "position"
    t.decimal  "search_columns"
    t.decimal  "cost"
    t.decimal  "cardinality"
    t.decimal  "bytes"
    t.string   "other_tag",         :limit => 35
    t.string   "partition_start",   :limit => 5
    t.string   "partition_stop",    :limit => 5
    t.decimal  "partition_id"
    t.string   "other",             :limit => 4000
    t.string   "distribution",      :limit => 20
    t.decimal  "cpu_cost"
    t.decimal  "io_cost"
    t.decimal  "temp_space"
    t.string   "access_predicates", :limit => 4000
    t.string   "filter_predicates", :limit => 4000
    t.string   "projection",        :limit => 4000
    t.decimal  "time"
    t.string   "qblock_name",       :limit => 31
    t.string   "remarks",           :limit => 4000
    t.datetime "timestamp"
    t.text     "other_xml"
  end

  create_table "wrh$_sql_summary", :id => false, :force => true do |t|
    t.decimal "snap_id",            :null => false
    t.decimal "dbid",               :null => false
    t.decimal "instance_number",    :null => false
    t.decimal "total_sql",          :null => false
    t.decimal "total_sql_mem",      :null => false
    t.decimal "single_use_sql",     :null => false
    t.decimal "single_use_sql_mem", :null => false
  end

  create_table "wrh$_sql_workarea_histogram", :id => false, :force => true do |t|
    t.decimal "snap_id",                :null => false
    t.decimal "dbid",                   :null => false
    t.decimal "instance_number",        :null => false
    t.decimal "low_optimal_size",       :null => false
    t.decimal "high_optimal_size",      :null => false
    t.decimal "optimal_executions"
    t.decimal "onepass_executions"
    t.decimal "multipasses_executions"
    t.decimal "total_executions"
  end

  create_table "wrh$_sqlstat", :id => false, :force => true do |t|
    t.decimal "snap_id",                                :null => false
    t.decimal "dbid",                                   :null => false
    t.decimal "instance_number",                        :null => false
    t.string  "sql_id",                   :limit => 13, :null => false
    t.decimal "plan_hash_value",                        :null => false
    t.decimal "optimizer_cost"
    t.string  "optimizer_mode",           :limit => 10
    t.decimal "optimizer_env_hash_value"
    t.decimal "sharable_mem"
    t.decimal "loaded_versions"
    t.decimal "version_count"
    t.string  "module",                   :limit => 64
    t.string  "action",                   :limit => 64
    t.string  "sql_profile",              :limit => 64
    t.decimal "force_matching_signature"
    t.decimal "parsing_schema_id"
    t.string  "parsing_schema_name",      :limit => 30
    t.decimal "fetches_total"
    t.decimal "fetches_delta"
    t.decimal "end_of_fetch_count_total"
    t.decimal "end_of_fetch_count_delta"
    t.decimal "sorts_total"
    t.decimal "sorts_delta"
    t.decimal "executions_total"
    t.decimal "executions_delta"
    t.decimal "px_servers_execs_total"
    t.decimal "px_servers_execs_delta"
    t.decimal "loads_total"
    t.decimal "loads_delta"
    t.decimal "invalidations_total"
    t.decimal "invalidations_delta"
    t.decimal "parse_calls_total"
    t.decimal "parse_calls_delta"
    t.decimal "disk_reads_total"
    t.decimal "disk_reads_delta"
    t.decimal "buffer_gets_total"
    t.decimal "buffer_gets_delta"
    t.decimal "rows_processed_total"
    t.decimal "rows_processed_delta"
    t.decimal "cpu_time_total"
    t.decimal "cpu_time_delta"
    t.decimal "elapsed_time_total"
    t.decimal "elapsed_time_delta"
    t.decimal "iowait_total"
    t.decimal "iowait_delta"
    t.decimal "clwait_total"
    t.decimal "clwait_delta"
    t.decimal "apwait_total"
    t.decimal "apwait_delta"
    t.decimal "ccwait_total"
    t.decimal "ccwait_delta"
    t.decimal "direct_writes_total"
    t.decimal "direct_writes_delta"
    t.decimal "plsexec_time_total"
    t.decimal "plsexec_time_delta"
    t.decimal "javexec_time_total"
    t.decimal "javexec_time_delta"
    t.raw     "bind_data"
    t.decimal "flag"
  end

  add_index "wrh$_sqlstat", ["sql_id", "dbid"], :name => "wrh$_sqlstat_index"

  create_table "wrh$_sqlstat_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                                :null => false
    t.decimal "dbid",                                   :null => false
    t.decimal "instance_number",                        :null => false
    t.string  "sql_id",                   :limit => 13, :null => false
    t.decimal "plan_hash_value",                        :null => false
    t.decimal "optimizer_cost"
    t.string  "optimizer_mode",           :limit => 10
    t.decimal "optimizer_env_hash_value"
    t.decimal "sharable_mem"
    t.decimal "loaded_versions"
    t.decimal "version_count"
    t.string  "module",                   :limit => 64
    t.string  "action",                   :limit => 64
    t.string  "sql_profile",              :limit => 64
    t.decimal "force_matching_signature"
    t.decimal "parsing_schema_id"
    t.string  "parsing_schema_name",      :limit => 30
    t.decimal "fetches_total"
    t.decimal "fetches_delta"
    t.decimal "end_of_fetch_count_total"
    t.decimal "end_of_fetch_count_delta"
    t.decimal "sorts_total"
    t.decimal "sorts_delta"
    t.decimal "executions_total"
    t.decimal "executions_delta"
    t.decimal "px_servers_execs_total"
    t.decimal "px_servers_execs_delta"
    t.decimal "loads_total"
    t.decimal "loads_delta"
    t.decimal "invalidations_total"
    t.decimal "invalidations_delta"
    t.decimal "parse_calls_total"
    t.decimal "parse_calls_delta"
    t.decimal "disk_reads_total"
    t.decimal "disk_reads_delta"
    t.decimal "buffer_gets_total"
    t.decimal "buffer_gets_delta"
    t.decimal "rows_processed_total"
    t.decimal "rows_processed_delta"
    t.decimal "cpu_time_total"
    t.decimal "cpu_time_delta"
    t.decimal "elapsed_time_total"
    t.decimal "elapsed_time_delta"
    t.decimal "iowait_total"
    t.decimal "iowait_delta"
    t.decimal "clwait_total"
    t.decimal "clwait_delta"
    t.decimal "apwait_total"
    t.decimal "apwait_delta"
    t.decimal "ccwait_total"
    t.decimal "ccwait_delta"
    t.decimal "direct_writes_total"
    t.decimal "direct_writes_delta"
    t.decimal "plsexec_time_total"
    t.decimal "plsexec_time_delta"
    t.decimal "javexec_time_total"
    t.decimal "javexec_time_delta"
    t.raw     "bind_data"
    t.decimal "flag"
  end

  add_index "wrh$_sqlstat_bl", ["sql_id", "dbid"], :name => "wrh$_sqlstat_bl_index", :tablespace => "sysaux"

  create_table "wrh$_sqltext", :id => false, :force => true do |t|
    t.decimal "snap_id"
    t.decimal "dbid",                       :null => false
    t.string  "sql_id",       :limit => 13, :null => false
    t.text    "sql_text"
    t.decimal "command_type"
    t.decimal "ref_count"
  end

  create_table "wrh$_stat_name", :id => false, :force => true do |t|
    t.decimal "dbid",                    :null => false
    t.decimal "stat_id",                 :null => false
    t.string  "stat_name", :limit => 64, :null => false
  end

  create_table "wrh$_streams_apply_sum", :id => false, :force => true do |t|
    t.decimal  "snap_id",                                      :null => false
    t.decimal  "dbid",                                         :null => false
    t.decimal  "instance_number",                              :null => false
    t.string   "apply_name",                     :limit => 30, :null => false
    t.datetime "startup_time",                                 :null => false
    t.decimal  "reader_total_messages_dequeued"
    t.decimal  "reader_lag"
    t.decimal  "coord_total_received"
    t.decimal  "coord_total_applied"
    t.decimal  "coord_total_rollbacks"
    t.decimal  "coord_total_wait_deps"
    t.decimal  "coord_total_wait_cmts"
    t.decimal  "coord_lwm_lag"
    t.decimal  "server_total_messages_applied"
    t.decimal  "server_elapsed_dequeue_time"
    t.decimal  "server_elapsed_apply_time"
  end

  create_table "wrh$_streams_capture", :id => false, :force => true do |t|
    t.decimal  "snap_id",                               :null => false
    t.decimal  "dbid",                                  :null => false
    t.decimal  "instance_number",                       :null => false
    t.string   "capture_name",            :limit => 30, :null => false
    t.datetime "startup_time",                          :null => false
    t.decimal  "lag"
    t.decimal  "total_messages_captured"
    t.decimal  "total_messages_enqueued"
    t.decimal  "elapsed_rule_time"
    t.decimal  "elapsed_enqueue_time"
    t.decimal  "elapsed_redo_wait_time"
    t.decimal  "elapsed_pause_time"
  end

  create_table "wrh$_streams_pool_advice", :id => false, :force => true do |t|
    t.decimal "snap_id",            :null => false
    t.decimal "dbid",               :null => false
    t.decimal "instance_number",    :null => false
    t.decimal "size_for_estimate",  :null => false
    t.decimal "size_factor"
    t.decimal "estd_spill_count"
    t.decimal "estd_spill_time"
    t.decimal "estd_unspill_count"
    t.decimal "estd_unspill_time"
  end

  create_table "wrh$_sys_time_model", :id => false, :force => true do |t|
    t.decimal "snap_id",         :null => false
    t.decimal "dbid",            :null => false
    t.decimal "instance_number", :null => false
    t.decimal "stat_id",         :null => false
    t.decimal "value"
  end

  create_table "wrh$_sys_time_model_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",         :null => false
    t.decimal "dbid",            :null => false
    t.decimal "instance_number", :null => false
    t.decimal "stat_id",         :null => false
    t.decimal "value"
  end

  create_table "wrh$_sysmetric_history", :id => false, :force => true do |t|
    t.decimal  "snap_id",         :null => false
    t.decimal  "dbid",            :null => false
    t.decimal  "instance_number", :null => false
    t.datetime "begin_time",      :null => false
    t.datetime "end_time",        :null => false
    t.decimal  "intsize",         :null => false
    t.decimal  "group_id",        :null => false
    t.decimal  "metric_id",       :null => false
    t.decimal  "value",           :null => false
  end

  add_index "wrh$_sysmetric_history", ["dbid", "snap_id", "instance_number", "group_id", "metric_id", "begin_time"], :name => "wrh$_sysmetric_history_index", :tablespace => "sysaux"

  create_table "wrh$_sysmetric_summary", :id => false, :force => true do |t|
    t.decimal  "snap_id",            :null => false
    t.decimal  "dbid",               :null => false
    t.decimal  "instance_number",    :null => false
    t.datetime "begin_time",         :null => false
    t.datetime "end_time",           :null => false
    t.decimal  "intsize",            :null => false
    t.decimal  "group_id",           :null => false
    t.decimal  "metric_id",          :null => false
    t.decimal  "num_interval",       :null => false
    t.decimal  "maxval",             :null => false
    t.decimal  "minval",             :null => false
    t.decimal  "average",            :null => false
    t.decimal  "standard_deviation", :null => false
  end

  add_index "wrh$_sysmetric_summary", ["dbid", "snap_id", "instance_number", "group_id", "metric_id"], :name => "wrh$_sysmetric_summary_index", :tablespace => "sysaux"

  create_table "wrh$_sysstat", :id => false, :force => true do |t|
    t.decimal "snap_id",         :null => false
    t.decimal "dbid",            :null => false
    t.decimal "instance_number", :null => false
    t.decimal "stat_id",         :null => false
    t.decimal "value"
  end

  create_table "wrh$_sysstat_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",         :null => false
    t.decimal "dbid",            :null => false
    t.decimal "instance_number", :null => false
    t.decimal "stat_id",         :null => false
    t.decimal "value"
  end

  create_table "wrh$_system_event", :id => false, :force => true do |t|
    t.decimal "snap_id",           :null => false
    t.decimal "dbid",              :null => false
    t.decimal "instance_number",   :null => false
    t.decimal "event_id",          :null => false
    t.decimal "total_waits"
    t.decimal "total_timeouts"
    t.decimal "time_waited_micro"
  end

  create_table "wrh$_system_event_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",           :null => false
    t.decimal "dbid",              :null => false
    t.decimal "instance_number",   :null => false
    t.decimal "event_id",          :null => false
    t.decimal "total_waits"
    t.decimal "total_timeouts"
    t.decimal "time_waited_micro"
  end

  create_table "wrh$_tablespace_space_usage", :id => false, :force => true do |t|
    t.decimal "dbid",                              :null => false
    t.decimal "snap_id"
    t.decimal "tablespace_id"
    t.decimal "tablespace_size"
    t.decimal "tablespace_maxsize"
    t.decimal "tablespace_usedsize"
    t.string  "rtime",               :limit => 25
  end

  add_index "wrh$_tablespace_space_usage", ["dbid", "snap_id", "tablespace_id"], :name => "wrh$_ts_space_usage_ind", :tablespace => "sysaux"

  create_table "wrh$_tablespace_stat", :id => false, :force => true do |t|
    t.decimal "snap_id",                                :null => false
    t.decimal "dbid",                                   :null => false
    t.decimal "instance_number",                        :null => false
    t.decimal "ts#",                                    :null => false
    t.string  "tsname",                   :limit => 30
    t.string  "contents",                 :limit => 9
    t.string  "status",                   :limit => 9
    t.string  "segment_space_management", :limit => 6
    t.string  "extent_management",        :limit => 10
    t.string  "is_backup",                :limit => 5
  end

  create_table "wrh$_tablespace_stat_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                                :null => false
    t.decimal "dbid",                                   :null => false
    t.decimal "instance_number",                        :null => false
    t.decimal "ts#",                                    :null => false
    t.string  "tsname",                   :limit => 30
    t.string  "contents",                 :limit => 9
    t.string  "status",                   :limit => 9
    t.string  "segment_space_management", :limit => 6
    t.string  "extent_management",        :limit => 10
    t.string  "is_backup",                :limit => 5
  end

  create_table "wrh$_tempfile", :id => false, :force => true do |t|
    t.decimal "snap_id"
    t.decimal "dbid",                            :null => false
    t.decimal "file#",                           :null => false
    t.decimal "creation_change#",                :null => false
    t.string  "filename",         :limit => 513, :null => false
    t.decimal "ts#",                             :null => false
    t.string  "tsname",           :limit => 30,  :null => false
    t.decimal "block_size"
  end

  create_table "wrh$_tempstatxs", :id => false, :force => true do |t|
    t.decimal "snap_id",          :null => false
    t.decimal "dbid",             :null => false
    t.decimal "instance_number",  :null => false
    t.decimal "file#",            :null => false
    t.decimal "creation_change#", :null => false
    t.decimal "phyrds"
    t.decimal "phywrts"
    t.decimal "singleblkrds"
    t.decimal "readtim"
    t.decimal "writetim"
    t.decimal "singleblkrdtim"
    t.decimal "phyblkrd"
    t.decimal "phyblkwrt"
    t.decimal "wait_count"
    t.decimal "time"
  end

  create_table "wrh$_thread", :id => false, :force => true do |t|
    t.decimal  "snap_id",                             :null => false
    t.decimal  "dbid",                                :null => false
    t.decimal  "instance_number",                     :null => false
    t.decimal  "thread#",                             :null => false
    t.decimal  "thread_instance_number"
    t.string   "status",                 :limit => 6
    t.datetime "open_time"
    t.decimal  "current_group#"
    t.decimal  "sequence#"
  end

  create_table "wrh$_undostat", :id => false, :force => true do |t|
    t.datetime "begin_time",                        :null => false
    t.datetime "end_time",                          :null => false
    t.decimal  "dbid",                              :null => false
    t.decimal  "instance_number",                   :null => false
    t.decimal  "snap_id",                           :null => false
    t.decimal  "undotsn",                           :null => false
    t.decimal  "undoblks"
    t.decimal  "txncount"
    t.decimal  "maxquerylen"
    t.string   "maxquerysqlid",       :limit => 13
    t.decimal  "maxconcurrency"
    t.decimal  "unxpstealcnt"
    t.decimal  "unxpblkrelcnt"
    t.decimal  "unxpblkreucnt"
    t.decimal  "expstealcnt"
    t.decimal  "expblkrelcnt"
    t.decimal  "expblkreucnt"
    t.decimal  "ssolderrcnt"
    t.decimal  "nospaceerrcnt"
    t.decimal  "activeblks"
    t.decimal  "unexpiredblks"
    t.decimal  "expiredblks"
    t.decimal  "tuned_undoretention"
    t.decimal  "status"
    t.decimal  "spcprs_retention"
    t.string   "runawayquerysqlid",   :limit => 13
  end

  create_table "wrh$_waitclassmetric_history", :id => false, :force => true do |t|
    t.decimal  "snap_id",              :null => false
    t.decimal  "dbid",                 :null => false
    t.decimal  "instance_number",      :null => false
    t.decimal  "wait_class_id",        :null => false
    t.datetime "begin_time",           :null => false
    t.datetime "end_time",             :null => false
    t.decimal  "intsize",              :null => false
    t.decimal  "group_id",             :null => false
    t.decimal  "average_waiter_count", :null => false
    t.decimal  "dbtime_in_wait",       :null => false
    t.decimal  "time_waited",          :null => false
    t.decimal  "wait_count",           :null => false
  end

  add_index "wrh$_waitclassmetric_history", ["dbid", "snap_id", "instance_number", "group_id", "wait_class_id", "begin_time"], :name => "wrh$_waitclassmetric_hist_ind", :tablespace => "sysaux"

  create_table "wrh$_waitstat", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "class",           :limit => 18, :null => false
    t.decimal "wait_count"
    t.decimal "time"
  end

  create_table "wrh$_waitstat_bl", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "class",           :limit => 18, :null => false
    t.decimal "wait_count"
    t.decimal "time"
  end

  create_table "wri$_adv_actions", :id => false, :force => true do |t|
    t.decimal "id",                        :null => false
    t.decimal "task_id",                   :null => false
    t.decimal "obj_id"
    t.decimal "command",                   :null => false
    t.decimal "flags"
    t.string  "attr1",     :limit => 4000
    t.string  "attr2",     :limit => 4000
    t.string  "attr3",     :limit => 4000
    t.string  "attr4",     :limit => 4000
    t.text    "attr5"
    t.text    "attr6"
    t.decimal "num_attr1"
    t.decimal "num_attr2"
    t.decimal "num_attr3"
    t.decimal "num_attr4"
    t.decimal "num_attr5"
    t.decimal "msg_id"
  end

  create_table "wri$_adv_asa_reco_data", :temporary => true, :id => false, :force => true do |t|
    t.decimal   "task_id"
    t.timestamp "ctime",        :limit => 6
    t.string    "segowner",     :limit => 100
    t.string    "segname",      :limit => 100
    t.string    "segtype",      :limit => 64
    t.string    "partname",     :limit => 100
    t.string    "tsname",       :limit => 100
    t.decimal   "benefit_type"
    t.decimal   "usp"
    t.decimal   "alsp"
    t.decimal   "rec"
    t.decimal   "chct"
    t.decimal   "cmd_id"
    t.string    "c1",           :limit => 1000
    t.string    "c2",           :limit => 1000
    t.string    "c3",           :limit => 1000
  end

  create_table "wri$_adv_def_parameters", :id => false, :force => true do |t|
    t.decimal "advisor_id",                  :null => false
    t.string  "name",        :limit => 30,   :null => false
    t.decimal "datatype",                    :null => false
    t.decimal "flags",                       :null => false
    t.string  "value",       :limit => 4000, :null => false
    t.string  "description", :limit => 9
  end

# Could not dump table "wri$_adv_definitions" because of following StandardError
#   Unknown type 'WRI$_ADV_ABSTRACT_T' for column 'type'

  create_table "wri$_adv_directives", :id => false, :force => true do |t|
    t.decimal "task_id",                       :null => false
    t.decimal "src_task_id"
    t.decimal "id",                            :null => false
    t.string  "obj_owner",     :limit => 30
    t.string  "obj_name",      :limit => 30
    t.decimal "rec_id"
    t.decimal "rec_action_id"
    t.decimal "command"
    t.string  "attr1",         :limit => 2000
    t.string  "attr2",         :limit => 2000
    t.string  "attr3",         :limit => 2000
    t.string  "attr4",         :limit => 2000
    t.text    "attr5"
  end

  create_table "wri$_adv_findings", :id => false, :force => true do |t|
    t.decimal "id",            :null => false
    t.decimal "task_id",       :null => false
    t.decimal "type",          :null => false
    t.decimal "parent",        :null => false
    t.decimal "obj_id"
    t.decimal "impact_msg_id"
    t.decimal "impact_val"
    t.decimal "msg_id"
    t.decimal "more_info_id"
  end

  create_table "wri$_adv_journal", :id => false, :force => true do |t|
    t.decimal "task_id", :null => false
    t.decimal "seq_id",  :null => false
    t.decimal "type",    :null => false
    t.decimal "msg_id",  :null => false
  end

  create_table "wri$_adv_message_groups", :id => false, :force => true do |t|
    t.decimal "task_id",                  :null => false
    t.decimal "id",                       :null => false
    t.decimal "seq",                      :null => false
    t.decimal "message#",                 :null => false
    t.string  "fac",      :limit => 3
    t.decimal "hdr"
    t.decimal "lm"
    t.decimal "nl"
    t.string  "p1",       :limit => 4000
    t.string  "p2",       :limit => 4000
    t.string  "p3",       :limit => 4000
    t.string  "p4",       :limit => 4000
    t.string  "p5",       :limit => 4000
  end

  add_index "wri$_adv_message_groups", ["task_id", "id"], :name => "wri$_adv_msg_grps_idx_01", :tablespace => "sysaux"

  create_table "wri$_adv_objects", :id => false, :force => true do |t|
    t.decimal "id",                      :null => false
    t.decimal "type",                    :null => false
    t.decimal "task_id",                 :null => false
    t.string  "attr1",   :limit => 4000
    t.string  "attr2",   :limit => 4000
    t.string  "attr3",   :limit => 4000
    t.text    "attr4"
    t.string  "attr5",   :limit => 4000
    t.text    "other"
  end

  create_table "wri$_adv_parameters", :id => false, :force => true do |t|
    t.decimal "task_id",                     :null => false
    t.string  "name",        :limit => 30,   :null => false
    t.string  "value",       :limit => 4000, :null => false
    t.decimal "datatype",                    :null => false
    t.decimal "flags",                       :null => false
    t.string  "description", :limit => 9
  end

  create_table "wri$_adv_rationale", :id => false, :force => true do |t|
    t.decimal "id",                            :null => false
    t.decimal "task_id",                       :null => false
    t.string  "type",          :limit => 30
    t.decimal "rec_id"
    t.decimal "impact_msg_id"
    t.decimal "impact_val"
    t.decimal "obj_id"
    t.decimal "msg_id"
    t.string  "attr1",         :limit => 4000
    t.string  "attr2",         :limit => 4000
    t.string  "attr3",         :limit => 4000
    t.string  "attr4",         :limit => 4000
    t.text    "attr5"
  end

  create_table "wri$_adv_rec_actions", :id => false, :force => true do |t|
    t.decimal "task_id", :null => false
    t.decimal "rec_id",  :null => false
    t.decimal "act_id",  :null => false
  end

  create_table "wri$_adv_recommendations", :id => false, :force => true do |t|
    t.decimal "id",                             :null => false
    t.decimal "task_id",                        :null => false
    t.string  "type",           :limit => 30
    t.decimal "finding_id"
    t.decimal "rank"
    t.string  "parent_recs",    :limit => 4000
    t.decimal "benefit_msg_id"
    t.decimal "benefit_val"
    t.decimal "annotation"
    t.decimal "flags"
  end

  create_table "wri$_adv_sqla_fake_reg", :id => false, :force => true do |t|
    t.decimal "task_id"
    t.string  "owner",     :limit => 30
    t.string  "name",      :limit => 30
    t.decimal "fake_type"
  end

  add_index "wri$_adv_sqla_fake_reg", ["task_id"], :name => "wri$_adv_sqla_freg_idx_01", :tablespace => "sysaux"

  create_table "wri$_adv_sqla_map", :id => false, :force => true do |t|
    t.decimal "task_id"
    t.decimal "workload_id"
  end

  add_index "wri$_adv_sqla_map", ["task_id"], :name => "wri$_adv_sqla_map_01", :tablespace => "sysaux"
  add_index "wri$_adv_sqla_map", ["workload_id"], :name => "wri$_adv_sqla_map_02", :tablespace => "sysaux"

  create_table "wri$_adv_sqla_stmts", :id => false, :force => true do |t|
    t.decimal "task_id",     :null => false
    t.decimal "workload_id"
    t.decimal "sql_id"
    t.decimal "pre_cost"
    t.decimal "post_cost"
    t.decimal "imp"
    t.decimal "rec_id"
    t.decimal "validated"
  end

  add_index "wri$_adv_sqla_stmts", ["task_id", "validated"], :name => "wri$_adv_sqla_stmts_idx_02", :tablespace => "sysaux"
  add_index "wri$_adv_sqla_stmts", ["task_id", "workload_id", "sql_id"], :name => "wri$_adv_sqla_stmts_idx_01", :tablespace => "sysaux"

  create_table "wri$_adv_sqla_tmp", :primary_key => "owner#", :force => true do |t|
  end

# Could not dump table "wri$_adv_sqlt_binds" because of following StandardError
#   Unknown type 'ANYDATA' for column 'value'

# Could not dump table "wri$_adv_sqlt_plans" because of following StandardError
#   Unknown type 'LONG' for column 'other'

  create_table "wri$_adv_sqlt_rtn_plan", :id => false, :force => true do |t|
    t.integer "task_id",      :precision => 38, :scale => 0, :null => false
    t.integer "rtn_id",       :precision => 38, :scale => 0, :null => false
    t.integer "object_id",    :precision => 38, :scale => 0, :null => false
    t.boolean "plan_attr",    :precision => 1,  :scale => 0, :null => false
    t.integer "operation_id", :precision => 38, :scale => 0, :null => false
  end

  create_table "wri$_adv_sqlt_statistics", :id => false, :force => true do |t|
    t.integer "task_id",                            :precision => 38, :scale => 0, :null => false
    t.integer "object_id",                          :precision => 38, :scale => 0, :null => false
    t.decimal "parsing_schema_id"
    t.string  "module",             :limit => 48
    t.string  "action",             :limit => 32
    t.decimal "elapsed_time"
    t.decimal "cpu_time"
    t.decimal "buffer_gets"
    t.decimal "disk_reads"
    t.decimal "direct_writes"
    t.decimal "rows_processed"
    t.decimal "fetches"
    t.decimal "executions"
    t.decimal "end_of_fetch_count"
    t.decimal "optimizer_cost"
    t.raw     "optimizer_env",      :limit => 1000
    t.decimal "command_type"
  end

  create_table "wri$_adv_sqlw_colvol", :id => false, :force => true do |t|
    t.decimal "workload_id",  :null => false
    t.decimal "table_owner#"
    t.decimal "table#",       :null => false
    t.decimal "col#",         :null => false
    t.decimal "upd_freq"
    t.decimal "upd_rows"
  end

  create_table "wri$_adv_sqlw_stmts", :id => false, :force => true do |t|
    t.decimal  "workload_id",                       :null => false
    t.decimal  "sql_id",                            :null => false
    t.decimal  "hash_value"
    t.decimal  "optimizer_cost"
    t.string   "username",            :limit => 30
    t.string   "module",              :limit => 64
    t.string   "action",              :limit => 64
    t.decimal  "elapsed_time"
    t.decimal  "cpu_time"
    t.decimal  "buffer_gets"
    t.decimal  "disk_reads"
    t.decimal  "rows_processed"
    t.decimal  "executions"
    t.decimal  "priority"
    t.datetime "last_execution_date"
    t.decimal  "command_type"
    t.decimal  "stat_period"
    t.text     "sql_text"
    t.decimal  "valid"
  end

  create_table "wri$_adv_sqlw_sum", :primary_key => "workload_id", :force => true do |t|
    t.string  "data_source", :limit => 2000
    t.decimal "num_select"
    t.decimal "num_insert"
    t.decimal "num_delete"
    t.decimal "num_update"
    t.decimal "num_merge"
    t.decimal "sqlset_id"
  end

  create_table "wri$_adv_sqlw_tables", :id => false, :force => true do |t|
    t.decimal "workload_id"
    t.decimal "sql_id"
    t.decimal "table_owner#"
    t.decimal "table#"
    t.string  "table_owner",  :limit => 30
    t.string  "table_name",   :limit => 30
    t.decimal "inst_id"
    t.decimal "hash_value"
    t.raw     "addr",         :limit => 16
    t.decimal "obj_type"
  end

  add_index "wri$_adv_sqlw_tables", ["workload_id", "sql_id"], :name => "wri$_adv_sqlw_tables_idx_01", :tablespace => "sysaux"

  create_table "wri$_adv_sqlw_tabvol", :id => false, :force => true do |t|
    t.decimal "workload_id",                :null => false
    t.string  "owner_name",   :limit => 30
    t.decimal "table_owner#"
    t.string  "table_name",   :limit => 30
    t.decimal "table#",                     :null => false
    t.decimal "upd_freq"
    t.decimal "ins_freq"
    t.decimal "del_freq"
    t.decimal "dir_freq"
    t.decimal "upd_rows"
    t.decimal "ins_rows"
    t.decimal "del_rows"
    t.decimal "dir_rows"
  end

  create_table "wri$_adv_tasks", :force => true do |t|
    t.decimal  "owner#",                             :null => false
    t.string   "owner_name",          :limit => 30
    t.string   "name",                :limit => 30
    t.string   "description",         :limit => 256
    t.decimal  "advisor_id",                         :null => false
    t.string   "advisor_name",        :limit => 30
    t.datetime "ctime",                              :null => false
    t.datetime "mtime",                              :null => false
    t.decimal  "parent_id"
    t.decimal  "parent_rec_id"
    t.decimal  "property",                           :null => false
    t.decimal  "version"
    t.datetime "exec_start"
    t.datetime "exec_end"
    t.decimal  "status",                             :null => false
    t.decimal  "status_msg_id"
    t.decimal  "pct_completion_time"
    t.decimal  "progress_metric"
    t.string   "metric_units",        :limit => 64
    t.decimal  "activity_counter"
    t.decimal  "rec_count"
    t.decimal  "error_msg#"
    t.decimal  "cleanup"
    t.string   "how_created",         :limit => 30
    t.string   "source",              :limit => 30
  end

  add_index "wri$_adv_tasks", ["advisor_id", "exec_start"], :name => "wri$_adv_tasks_idx_03", :tablespace => "sysaux"
  add_index "wri$_adv_tasks", ["name", "owner#"], :name => "wri$_adv_tasks_idx_01", :unique => true, :tablespace => "sysaux"
  add_index "wri$_adv_tasks", ["owner#", "id"], :name => "wri$_adv_tasks_idx_02", :unique => true, :tablespace => "sysaux"

  create_table "wri$_adv_usage", :id => false, :force => true do |t|
    t.decimal  "advisor_id",     :null => false
    t.datetime "last_exec_time", :null => false
    t.decimal  "num_execs",      :null => false
  end

  create_table "wri$_aggregation_enabled", :id => false, :force => true do |t|
    t.decimal "trace_type",                  :null => false
    t.string  "primary_id",    :limit => 64
    t.string  "qualifier_id1", :limit => 48
    t.string  "qualifier_id2", :limit => 32
    t.string  "instance_name", :limit => 16
  end

  add_index "wri$_aggregation_enabled", ["trace_type", "primary_id", "qualifier_id1", "qualifier_id2", "instance_name"], :name => "wri$_aggregation_ind1", :unique => true, :tablespace => "sysaux"

  create_table "wri$_alert_history", :primary_key => "sequence_id", :force => true do |t|
    t.decimal   "reason_id"
    t.string    "owner",                :limit => 30
    t.string    "object_name",          :limit => 513
    t.string    "subobject_name",       :limit => 30
    t.string    "reason_argument_1",    :limit => 581
    t.string    "reason_argument_2",    :limit => 581
    t.string    "reason_argument_3",    :limit => 581
    t.string    "reason_argument_4",    :limit => 581
    t.string    "reason_argument_5",    :limit => 581
    t.timestamp "time_suggested",       :limit => 6
    t.timestamp "creation_time",        :limit => 6
    t.string    "action_argument_1",    :limit => 30
    t.string    "action_argument_2",    :limit => 30
    t.string    "action_argument_3",    :limit => 30
    t.string    "action_argument_4",    :limit => 30
    t.string    "action_argument_5",    :limit => 30
    t.decimal   "message_level"
    t.string    "hosting_client_id",    :limit => 64
    t.string    "process_id",           :limit => 128
    t.string    "host_id",              :limit => 256
    t.string    "host_nw_addr",         :limit => 256
    t.string    "instance_name",        :limit => 16
    t.decimal   "instance_number"
    t.string    "user_id",              :limit => 30
    t.string    "execution_context_id", :limit => 60
    t.string    "error_instance_id",    :limit => 142
    t.decimal   "resolution"
    t.decimal   "metric_value"
  end

  create_table "wri$_alert_outstanding", :id => false, :force => true do |t|
    t.decimal   "reason_id",                               :null => false
    t.decimal   "object_id",                               :null => false
    t.decimal   "subobject_id",                            :null => false
    t.decimal   "internal_instance_number",                :null => false
    t.string    "owner",                    :limit => 30
    t.string    "object_name",              :limit => 513
    t.string    "subobject_name",           :limit => 30
    t.decimal   "sequence_id"
    t.string    "reason_argument_1",        :limit => 581
    t.string    "reason_argument_2",        :limit => 581
    t.string    "reason_argument_3",        :limit => 581
    t.string    "reason_argument_4",        :limit => 581
    t.string    "reason_argument_5",        :limit => 581
    t.timestamp "time_suggested",           :limit => 6
    t.timestamp "creation_time",            :limit => 6
    t.string    "action_argument_1",        :limit => 30
    t.string    "action_argument_2",        :limit => 30
    t.string    "action_argument_3",        :limit => 30
    t.string    "action_argument_4",        :limit => 30
    t.string    "action_argument_5",        :limit => 30
    t.decimal   "message_level"
    t.string    "hosting_client_id",        :limit => 64
    t.string    "process_id",               :limit => 128
    t.string    "host_id",                  :limit => 256
    t.string    "host_nw_addr",             :limit => 256
    t.string    "instance_name",            :limit => 16
    t.decimal   "instance_number"
    t.string    "user_id",                  :limit => 30
    t.string    "execution_context_id",     :limit => 60
    t.string    "error_instance_id",        :limit => 142
    t.raw       "context",                  :limit => 128
    t.decimal   "metric_value"
  end

  create_table "wri$_alert_threshold", :id => false, :force => true do |t|
    t.decimal "t_object_type"
    t.string  "t_object_name",             :limit => 513
    t.decimal "t_metrics_id"
    t.string  "t_instance_name",           :limit => 16
    t.decimal "t_flags"
    t.decimal "t_warning_operator"
    t.string  "t_warning_value",           :limit => 256
    t.decimal "t_critical_operator"
    t.string  "t_critical_value",          :limit => 256
    t.decimal "t_observation_period"
    t.decimal "t_consecutive_occurrences"
    t.decimal "t_object_id"
  end

  add_index "wri$_alert_threshold", ["t_object_type", "t_object_name", "t_metrics_id", "t_instance_name"], :name => "wri$_alert_threshold_pk", :unique => true, :tablespace => "sysaux"

  create_table "wri$_alert_threshold_log", :primary_key => "sequence_id", :force => true do |t|
    t.decimal "object_type"
    t.string  "object_name", :limit => 513
    t.decimal "object_id"
    t.decimal "opcode"
  end

  create_table "wri$_dbu_cpu_usage", :id => false, :force => true do |t|
    t.decimal  "dbid",                           :null => false
    t.string   "version",          :limit => 17, :null => false
    t.datetime "timestamp",                      :null => false
    t.decimal  "cpu_count"
    t.decimal  "cpu_core_count"
    t.decimal  "cpu_socket_count"
  end

  create_table "wri$_dbu_cpu_usage_sample", :id => false, :force => true do |t|
    t.decimal  "dbid",                               :null => false
    t.string   "version",              :limit => 17, :null => false
    t.datetime "last_sample_date"
    t.decimal  "last_sample_date_num"
    t.decimal  "last_sample_period"
    t.decimal  "total_samples",                      :null => false
    t.decimal  "sample_interval"
  end

  create_table "wri$_dbu_feature_metadata", :primary_key => "name", :force => true do |t|
    t.integer "inst_chk_method",                :precision => 38, :scale => 0
    t.text    "inst_chk_logic"
    t.integer "usg_det_method",                 :precision => 38, :scale => 0
    t.text    "usg_det_logic"
    t.string  "description",     :limit => 128
  end

  create_table "wri$_dbu_feature_usage", :id => false, :force => true do |t|
    t.string   "name",             :limit => 64, :null => false
    t.decimal  "dbid",                           :null => false
    t.string   "version",          :limit => 17, :null => false
    t.datetime "first_usage_date"
    t.datetime "last_usage_date"
    t.decimal  "detected_usages",                :null => false
    t.decimal  "aux_count"
    t.text     "feature_info"
    t.decimal  "error_count"
  end

  create_table "wri$_dbu_high_water_mark", :id => false, :force => true do |t|
    t.string  "name",        :limit => 64, :null => false
    t.decimal "dbid",                      :null => false
    t.string  "version",     :limit => 17, :null => false
    t.decimal "highwater"
    t.decimal "last_value"
    t.decimal "error_count"
  end

  create_table "wri$_dbu_hwm_metadata", :primary_key => "name", :force => true do |t|
    t.integer "method",                     :precision => 38, :scale => 0
    t.text    "logic"
    t.string  "description", :limit => 128
  end

  create_table "wri$_dbu_usage_sample", :id => false, :force => true do |t|
    t.decimal  "dbid",                               :null => false
    t.string   "version",              :limit => 17, :null => false
    t.datetime "last_sample_date"
    t.decimal  "last_sample_date_num"
    t.decimal  "last_sample_period"
    t.decimal  "total_samples",                      :null => false
    t.decimal  "sample_interval"
  end

  create_table "wri$_optstat_aux_history", :id => false, :force => true do |t|
    t.timestamp "savtime", :limit => 6
    t.string    "sname",   :limit => 30
    t.string    "pname",   :limit => 30
    t.decimal   "pval1"
    t.string    "pval2"
    t.decimal   "spare1"
    t.decimal   "spare2"
    t.decimal   "spare3"
    t.string    "spare4",  :limit => 1000
    t.string    "spare5",  :limit => 1000
    t.timestamp "spare6",  :limit => 6
  end

  add_index "wri$_optstat_aux_history", ["SYS_EXTRACT_UTC(\"SAVTIME\")"], :name => "i_wri$_optstat_aux_st", :tablespace => "sysaux"

  create_table "wri$_optstat_histgrm_history", :id => false, :force => true do |t|
    t.decimal   "obj#",                     :null => false
    t.decimal   "intcol#",                  :null => false
    t.timestamp "savtime",  :limit => 6
    t.decimal   "bucket",                   :null => false
    t.decimal   "endpoint",                 :null => false
    t.string    "epvalue",  :limit => 1000
    t.decimal   "spare1"
    t.decimal   "spare2"
    t.decimal   "spare3"
    t.string    "spare4",   :limit => 1000
    t.string    "spare5",   :limit => 1000
    t.timestamp "spare6",   :limit => 6
  end

  add_index "wri$_optstat_histgrm_history", ["SYS_EXTRACT_UTC(\"SAVTIME\")"], :name => "i_wri$_optstat_h_st", :tablespace => "sysaux"
  add_index "wri$_optstat_histgrm_history", ["obj#", "intcol#", "SYS_EXTRACT_UTC(\"SAVTIME\")"], :name => "i_wri$_optstat_h_obj#_icol#_st", :tablespace => "sysaux"

  create_table "wri$_optstat_histhead_history", :id => false, :force => true do |t|
    t.decimal   "obj#",                           :null => false
    t.decimal   "intcol#",                        :null => false
    t.timestamp "savtime",        :limit => 6
    t.decimal   "flags"
    t.decimal   "null_cnt"
    t.decimal   "minimum"
    t.decimal   "maximum"
    t.decimal   "distcnt"
    t.decimal   "density"
    t.raw       "lowval",         :limit => 32
    t.raw       "hival",          :limit => 32
    t.decimal   "avgcln"
    t.decimal   "sample_distcnt"
    t.decimal   "sample_size"
    t.datetime  "timestamp#"
    t.decimal   "spare1"
    t.decimal   "spare2"
    t.decimal   "spare3"
    t.string    "spare4",         :limit => 1000
    t.string    "spare5",         :limit => 1000
    t.timestamp "spare6",         :limit => 6
  end

  add_index "wri$_optstat_histhead_history", ["SYS_EXTRACT_UTC(\"SAVTIME\")"], :name => "i_wri$_optstat_hh_st", :tablespace => "sysaux"
  add_index "wri$_optstat_histhead_history", ["obj#", "intcol#", "SYS_EXTRACT_UTC(\"SAVTIME\")"], :name => "i_wri$_optstat_hh_obj_icol_st", :unique => true, :tablespace => "sysaux"

  create_table "wri$_optstat_ind_history", :id => false, :force => true do |t|
    t.decimal   "obj#",                        :null => false
    t.timestamp "savtime",     :limit => 6
    t.decimal   "flags"
    t.decimal   "rowcnt"
    t.decimal   "blevel"
    t.decimal   "leafcnt"
    t.decimal   "distkey"
    t.decimal   "lblkkey"
    t.decimal   "dblkkey"
    t.decimal   "clufac"
    t.decimal   "samplesize"
    t.datetime  "analyzetime"
    t.decimal   "guessq"
    t.decimal   "cachedblk"
    t.decimal   "cachehit"
    t.decimal   "logicalread"
    t.decimal   "spare1"
    t.decimal   "spare2"
    t.decimal   "spare3"
    t.string    "spare4",      :limit => 1000
    t.string    "spare5",      :limit => 1000
    t.timestamp "spare6",      :limit => 6
  end

  add_index "wri$_optstat_ind_history", ["SYS_EXTRACT_UTC(\"SAVTIME\")"], :name => "i_wri$_optstat_ind_st", :tablespace => "sysaux"
  add_index "wri$_optstat_ind_history", ["obj#", "SYS_EXTRACT_UTC(\"SAVTIME\")"], :name => "i_wri$_optstat_ind_obj#_st", :unique => true, :tablespace => "sysaux"

  create_table "wri$_optstat_opr", :id => false, :force => true do |t|
    t.string    "operation",  :limit => 64
    t.string    "target",     :limit => 64
    t.timestamp "start_time", :limit => 6
    t.timestamp "end_time",   :limit => 6
    t.decimal   "flags"
    t.decimal   "spare1"
    t.decimal   "spare2"
    t.decimal   "spare3"
    t.string    "spare4",     :limit => 1000
    t.string    "spare5",     :limit => 1000
    t.timestamp "spare6",     :limit => 6
  end

  add_index "wri$_optstat_opr", ["SYS_EXTRACT_UTC(\"START_TIME\")"], :name => "i_wri$_optstat_opr_stime", :tablespace => "sysaux"

  create_table "wri$_optstat_tab_history", :id => false, :force => true do |t|
    t.decimal   "obj#",                        :null => false
    t.timestamp "savtime",     :limit => 6
    t.decimal   "flags"
    t.decimal   "rowcnt"
    t.decimal   "blkcnt"
    t.decimal   "avgrln"
    t.decimal   "samplesize"
    t.datetime  "analyzetime"
    t.decimal   "cachedblk"
    t.decimal   "cachehit"
    t.decimal   "logicalread"
    t.decimal   "spare1"
    t.decimal   "spare2"
    t.decimal   "spare3"
    t.string    "spare4",      :limit => 1000
    t.string    "spare5",      :limit => 1000
    t.timestamp "spare6",      :limit => 6
  end

  add_index "wri$_optstat_tab_history", ["SYS_EXTRACT_UTC(\"SAVTIME\")"], :name => "i_wri$_optstat_tab_st", :tablespace => "sysaux"
  add_index "wri$_optstat_tab_history", ["obj#", "SYS_EXTRACT_UTC(\"SAVTIME\")"], :name => "i_wri$_optstat_tab_obj#_st", :unique => true, :tablespace => "sysaux"

  create_table "wri$_sch_control", :primary_key => "schedule_id", :force => true do |t|
    t.decimal "schedule_mode",   :null => false
    t.decimal "start_calibrate"
    t.decimal "last_vote"
    t.decimal "num_votes"
    t.decimal "synced_time"
    t.decimal "status"
  end

  create_table "wri$_sch_votes", :id => false, :force => true do |t|
    t.decimal "schedule_id",  :null => false
    t.decimal "vector_index", :null => false
    t.decimal "vector"
  end

  create_table "wri$_segadv_cntrltab", :primary_key => "auto_taskid", :force => true do |t|
    t.decimal   "snapid"
    t.decimal   "segments_selected"
    t.decimal   "segments_processed"
    t.decimal   "tablespace_selected"
    t.decimal   "tablespace_processed"
    t.decimal   "recommendations_count"
    t.timestamp "start_time",            :limit => 6
    t.timestamp "end_time",              :limit => 6
  end

  create_table "wri$_segadv_objlist", :id => false, :force => true do |t|
    t.decimal   "auto_taskid"
    t.decimal   "ts_id"
    t.decimal   "objn"
    t.decimal   "objd"
    t.string    "status",          :limit => 40
    t.decimal   "task_id"
    t.string    "reason",          :limit => 40
    t.decimal   "reason_value"
    t.timestamp "creation_time",   :limit => 6
    t.decimal   "proc_taskid"
    t.timestamp "end_time",        :limit => 6
    t.string    "segment_owner",   :limit => 30
    t.string    "segment_name",    :limit => 81
    t.string    "partition_name",  :limit => 30
    t.string    "segment_type",    :limit => 18
    t.string    "tablespace_name", :limit => 30
  end

  add_index "wri$_segadv_objlist", ["auto_taskid"], :name => "wri$_segadv_objlist_idx_aid"
  add_index "wri$_segadv_objlist", ["objd"], :name => "wri$_segadv_objlist_idx_objd"
  add_index "wri$_segadv_objlist", ["ts_id", "objn", "objd"], :name => "wri$_segadv_objlist_idx_obj"
  add_index "wri$_segadv_objlist", ["ts_id"], :name => "wri$_segadv_objlist_idx_ts"

# Could not dump table "wri$_sqlset_binds" because of following StandardError
#   Unknown type 'ANYDATA' for column 'value'

  create_table "wri$_sqlset_definitions", :force => true do |t|
    t.string   "name",            :limit => 30,  :null => false
    t.string   "owner",           :limit => 30
    t.string   "description",     :limit => 256
    t.datetime "created"
    t.datetime "last_modified"
    t.decimal  "statement_count"
  end

  add_index "wri$_sqlset_definitions", ["name", "owner"], :name => "wri$_sqlset_definitions_idx_01", :unique => true, :tablespace => "sysaux"

  create_table "wri$_sqlset_mask", :id => false, :force => true do |t|
    t.decimal "stmt_id",         :null => false
    t.decimal "plan_hash_value", :null => false
    t.decimal "priority"
    t.text    "other"
  end

# Could not dump table "wri$_sqlset_plan_lines" because of following StandardError
#   Unknown type 'LONG' for column 'other'

  create_table "wri$_sqlset_plans", :id => false, :force => true do |t|
    t.decimal  "stmt_id",                             :null => false
    t.decimal  "plan_hash_value",                     :null => false
    t.string   "parsing_schema_name", :limit => 30
    t.raw      "bind_data"
    t.raw      "optimizer_env",       :limit => 1000
    t.datetime "plan_timestamp"
    t.string   "binds_captured",      :limit => 1
  end

  create_table "wri$_sqlset_plans_tocap", :temporary => true, :id => false, :force => true do |t|
    t.decimal  "stmt_id",                       :null => false
    t.string   "sql_id",          :limit => 13
    t.decimal  "plan_hash_value",               :null => false
    t.datetime "last_load_time"
  end

  create_table "wri$_sqlset_references", :id => false, :force => true do |t|
    t.decimal  "id",                         :null => false
    t.decimal  "sqlset_id",                  :null => false
    t.string   "owner",       :limit => 30
    t.datetime "created"
    t.string   "description", :limit => 256
  end

  create_table "wri$_sqlset_statements", :force => true do |t|
    t.decimal "sqlset_id",                              :null => false
    t.string  "sql_id",                   :limit => 13, :null => false
    t.decimal "force_matching_signature",               :null => false
    t.string  "parsing_schema_name",      :limit => 30
    t.string  "module",                   :limit => 48
    t.string  "action",                   :limit => 32
    t.decimal "command_type"
  end

  add_index "wri$_sqlset_statements", ["sqlset_id", "force_matching_signature"], :name => "wri$_sqlset_statements_idx_02", :tablespace => "sysaux"
  add_index "wri$_sqlset_statements", ["sqlset_id", "sql_id"], :name => "wri$_sqlset_statements_idx_01", :unique => true, :tablespace => "sysaux"

  create_table "wri$_sqlset_statistics", :id => false, :force => true do |t|
    t.decimal "stmt_id",                             :null => false
    t.decimal "plan_hash_value",                     :null => false
    t.decimal "elapsed_time"
    t.decimal "elapsed_time_delta"
    t.decimal "cpu_time"
    t.decimal "cpu_time_delta"
    t.decimal "buffer_gets"
    t.decimal "buffer_gets_delta"
    t.decimal "disk_reads"
    t.decimal "disk_reads_delta"
    t.decimal "direct_writes"
    t.decimal "direct_writes_delta"
    t.decimal "rows_processed"
    t.decimal "rows_processed_delta"
    t.decimal "fetches"
    t.decimal "fetches_delta"
    t.decimal "executions"
    t.decimal "executions_delta"
    t.decimal "end_of_fetch_count"
    t.decimal "optimizer_cost"
    t.string  "first_load_time",       :limit => 19
    t.string  "first_load_time_delta", :limit => 19
    t.decimal "stat_period"
    t.decimal "active_stat_period"
  end

# Could not dump table "wri$_sqlset_workspace" because of following StandardError
#   Unknown type 'SQL_PLAN_TABLE_TYPE' for column 'sql_plan'

  create_table "wri$_tracing_enabled", :id => false, :force => true do |t|
    t.decimal "trace_type",                  :null => false
    t.string  "primary_id",    :limit => 64
    t.string  "qualifier_id1", :limit => 48
    t.string  "qualifier_id2", :limit => 32
    t.string  "instance_name", :limit => 16
    t.decimal "flags"
  end

  add_index "wri$_tracing_enabled", ["trace_type", "primary_id", "qualifier_id1", "qualifier_id2", "instance_name"], :name => "wri$_tracing_ind1", :unique => true, :tablespace => "sysaux"

  create_table "wrm$_baseline", :id => false, :force => true do |t|
    t.decimal "dbid",                        :null => false
    t.decimal "baseline_id",                 :null => false
    t.string  "baseline_name", :limit => 64
    t.decimal "start_snap_id",               :null => false
    t.decimal "end_snap_id",                 :null => false
  end

  create_table "wrm$_database_instance", :id => false, :force => true do |t|
    t.decimal   "dbid",                             :null => false
    t.decimal   "instance_number",                  :null => false
    t.timestamp "startup_time",       :limit => 3,  :null => false
    t.string    "parallel",           :limit => 3,  :null => false
    t.string    "version",            :limit => 17, :null => false
    t.string    "db_name",            :limit => 9
    t.string    "instance_name",      :limit => 16
    t.string    "host_name",          :limit => 64
    t.decimal   "last_ash_sample_id",               :null => false
  end

  create_table "wrm$_snap_error", :id => false, :force => true do |t|
    t.decimal "snap_id",                       :null => false
    t.decimal "dbid",                          :null => false
    t.decimal "instance_number",               :null => false
    t.string  "table_name",      :limit => 30, :null => false
    t.decimal "error_number",                  :null => false
  end

  create_table "wrm$_snapshot", :id => false, :force => true do |t|
    t.decimal   "snap_id",                          :null => false
    t.decimal   "dbid",                             :null => false
    t.decimal   "instance_number",                  :null => false
    t.timestamp "startup_time",        :limit => 3, :null => false
    t.timestamp "begin_interval_time", :limit => 3, :null => false
    t.timestamp "end_interval_time",   :limit => 3, :null => false
    t.integer   "flush_elapsed",       :limit => 5
    t.decimal   "snap_level"
    t.decimal   "status"
    t.decimal   "error_count"
    t.decimal   "bl_moved"
    t.decimal   "snap_flag"
  end

  create_table "wrm$_wr_control", :primary_key => "dbid", :force => true do |t|
    t.integer   "snap_interval",          :limit => 5, :null => false
    t.decimal   "snapint_num"
    t.integer   "retention",              :limit => 5, :null => false
    t.decimal   "retention_num"
    t.decimal   "most_recent_snap_id",                 :null => false
    t.timestamp "most_recent_snap_time",  :limit => 3
    t.decimal   "mrct_snap_time_num"
    t.decimal   "status_flag"
    t.timestamp "most_recent_purge_time", :limit => 3
    t.decimal   "mrct_purge_time_num"
    t.decimal   "most_recent_split_id"
    t.decimal   "most_recent_split_time"
    t.decimal   "swrf_version"
    t.decimal   "registration_status"
    t.decimal   "mrct_baseline_id"
    t.decimal   "topnsql"
  end

  create_table "xdb_installation_tab", :id => false, :force => true do |t|
    t.string "owner",       :limit => 200
    t.string "object_name", :limit => 200
    t.string "object_type", :limit => 200
  end

  add_foreign_key "attribute_transformations$", "transformations$", :column => "transformation_id", :primary_key => nil, :name => "attribute_transformations_fk", :dependent => :delete

  add_foreign_key "hs$_class_caps", "hs$_base_caps", :column => "cap_number", :primary_key => nil, :name => "hs$_class_caps_fk2", :dependent => :delete
  add_foreign_key "hs$_class_caps", "hs$_fds_class", :column => "fds_class_id", :primary_key => nil, :name => "hs$_class_caps_fk1", :dependent => :delete

  add_foreign_key "hs$_class_dd", "hs$_base_dd", :column => "dd_table_id", :primary_key => nil, :name => "hs$_class_dd_fk2", :dependent => :delete
  add_foreign_key "hs$_class_dd", "hs$_fds_class", :column => "fds_class_id", :primary_key => nil, :name => "hs$_class_dd_fk1", :dependent => :delete

  add_foreign_key "hs$_class_init", "hs$_fds_class", :column => "fds_class_id", :primary_key => nil, :name => "hs$_class_init_fk1", :dependent => :delete

  add_foreign_key "hs$_fds_inst", "hs$_fds_class", :column => "fds_class_id", :primary_key => nil, :name => "hs$_fds_inst_fk1", :dependent => :delete

  add_foreign_key "hs$_inst_caps", "hs$_base_caps", :column => "cap_number", :primary_key => nil, :name => "hs$_inst_caps_fk2", :dependent => :delete
  add_foreign_key "hs$_inst_caps", "hs$_fds_inst", :column => "fds_inst_id", :primary_key => nil, :name => "hs$_inst_caps_fk1", :dependent => :delete

  add_foreign_key "hs$_inst_dd", "hs$_base_dd", :column => "dd_table_id", :primary_key => nil, :name => "hs$_inst_dd_fk2", :dependent => :delete
  add_foreign_key "hs$_inst_dd", "hs$_fds_inst", :column => "fds_inst_id", :primary_key => nil, :name => "hs$_inst_dd_fk1", :dependent => :delete

  add_foreign_key "hs$_inst_init", "hs$_fds_inst", :column => "fds_inst_id", :primary_key => nil, :name => "hs$_inst_init_fk1", :dependent => :delete

  add_foreign_key "registry$", "registry$", :columns => ["namespace", "pid"], :name => "registry_parent_fk", :dependent => :delete

  add_foreign_key "registry$schemas", "registry$", :columns => ["cid", "namespace"], :name => "registry_schema_fk", :dependent => :delete

  add_foreign_key "wrm$_snapshot", "wrm$_database_instance", :columns => ["dbid", "instance_number", "startup_time"], :name => "wrm$_snapshot_fk", :dependent => :delete

  add_synonym "def$_aqcall", "system.def$_aqcall", :force => true
  add_synonym "def$_calldest", "system.def$_calldest", :force => true
  add_synonym "def$_schedule", "system.def$_schedule", :force => true
  add_synonym "def$_error", "system.def$_error", :force => true
  add_synonym "def$_defaultdest", "system.def$_defaultdest", :force => true
  add_synonym "def$_lob", "system.def$_lob", :force => true
  add_synonym "xmldom", "xdb.dbms_xmldom", :force => true
  add_synonym "xmlparser", "xdb.dbms_xmlparser", :force => true
  add_synonym "xslprocessor", "xdb.dbms_xslprocessor", :force => true

end
