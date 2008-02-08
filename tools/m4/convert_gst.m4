dnl 
dnl Glib C names have prefix 'G' but C++ namespace Glib
dnl 
define(`_CONV_GST_ENUM',`dnl
_CONVERSION(`GST$1', `$1', (($1)(__ARG3__)))
_CONVERSION(`GST$1', `$1', ((Glib::$1)(__ARG3__)))
_CONVERSION(`$1', `GST$1', ((GST$1)(__ARG3__)))
_CONVERSION(`$1', `GST$1', ((GST$1)(__ARG3__)))
')dnl

_CONVERSION(`GstObject*',`Glib::RefPtr<Gst::Object>',`Glib::wrap($3)')
_CONVERSION(`GstObject*',`Glib::RefPtr<const Gst::Object>',`Glib::wrap($3)')
_CONVERSION(`const Glib::RefPtr<Gst::Object>&',`GstObject*',`Glib::unwrap($3)')

#_CONVERSION(`Glib::RefPtr<Object>&',`GstObject*', `Glib::unwrap($3)')
_CONVERSION(`State&',`GstState*',`((GstState*) (&($3)))')
_CONVERSION(`GstClockTime',`ClockTime',`$3')
_CONVERSION(`ClockTime',`GstClockTime',`(GstClockTime ($3))')
_CONVERSION(`guint64',`ClockTime',`(ClockTime ($3))')
_CONVERSION(`GstClockID',`Glib::RefPtr<ClockID>',`$3')
_CONVERSION(`Glib::RefPtr<ClockID>',`GstClockID',`(GstClockID ($3))')
_CONVERSION(`GstClock*',`Clock',`Glib::wrap($3)')
_CONVERSION(`const Clock&',`GstClock*',`((GstClock*) (&($3)))')
_CONVERSION(`const Format&',`GstFormat*',`((GstFormat*) (&($3)))')
_CONVERSION(`const gint64&',`gint64*',`((gint64*) (&($3)))')
_CONVERSION(`const std::string&',`const guchar*',`(const guchar*) ($3.c_str())')
_CONVERSION(`Glib::RefPtr<Element>',`GstElement*', `Glib::unwrap($3)')
_CONVERSION(`GstPad*',`Glib::RefPtr<Pad>',`Glib::wrap($3)')
_CONVERSION(`GstPad*',`Glib::RefPtr<const Pad>',`Glib::wrap($3)')
_CONVERSION(`GstCaps*',`Glib::RefPtr<Caps>',`Glib::wrap($3)')
_CONVERSION(`GstElement*',`Glib::RefPtr<Element>',`Glib::wrap($3)')
_CONVERSION(`GstElement*',`Glib::RefPtr<const Element>',`Glib::wrap($3)')
_CONVERSION(`GstClock*',`Glib::RefPtr<Clock>',`Glib::wrap($3)')
_CONVERSION(`GstClock*',`Glib::RefPtr<const Clock>',`Glib::wrap($3)')
#_CONVERSION(`Glib::RefPtr<Pad>',`GstPad*', `Glib::unwrap($3)')
_CONVERSION(`const Glib::RefPtr<Pad>&',`GstPad*', `Glib::unwrap($3)')
_CONVERSION(`const Glib::RefPtr<Element>&',`GstElement*', `Glib::unwrap($3)')
_CONVERSION(`const Glib::RefPtr<Clock>&',`GstClock*', `Glib::unwrap($3)')
_CONVERSION(`GstMessage*',`Glib::RefPtr<Message>',`Gst::Message::wrap($3)')
_CONVERSION(`GstMessage*',`Glib::RefPtr<const Message>',`Gst::Message::wrap($3)')
_CONVERSION(`const Glib::RefPtr<Message>&',`GstMessage*', `Glib::unwrap($3)')
_CONVERSION(`const Glib::RefPtr<Event>&',`GstEvent*', `Glib::unwrap($3)')
_CONVERSION(`const Glib::RefPtr<Query>&',`GstQuery*', `Glib::unwrap($3)')
_CONVERSION(`const Glib::RefPtr<Caps>&',`GstCaps*', `Glib::unwrap($3)')
_CONVERSION(`const Glib::RefPtr<Bus>&',`GstBus*', `Glib::unwrap($3)')
_CONVERSION(`GstBuffer*',`Glib::RefPtr<Buffer>',`wrap($3)')
_CONVERSION(`const Glib::RefPtr<Buffer>&',`GstBuffer*', `Glib::unwrap($3)')
_CONVERSION(`const Glib::RefPtr<Buffer>&',`const GstBuffer*', `Glib::unwrap($3)')
_CONVERSION(`Glib::RefPtr<Buffer>',`GstBuffer*', `Glib::unwrap($3)')

_CONVERSION(`Structure&',`GstStructure*',`((GstStructure*)(&($3)))')
_CONVERSION(`GstStructure*',`Structure*',`((Structure*) ($3))')
_CONVERSION(`const Glib::RefPtr<Caps>&',`const GstCaps*', `Glib::unwrap($3)')
_CONVERSION(`const xmlNodePtr&',`xmlNodePtr',`$3')
_CONVERSION(`const va_list&',`va_list',`const_cast<va_list&>($3)')
_CONVERSION(`GstBus*',`Glib::RefPtr<Bus>',`Glib::wrap($3)')

_CONVERSION(`Format&',`GstFormat*',`(($2) &($3))')
_CONVERSION(`const gint64&',`gint64',`$3')
_CONVERSION(`gint64&',`gint64*',`&($3)')
_CONVERSION(`const double&',`gdouble',`$3')
_CONVERSION(`const guint&',`guint',`$3')
_CONVERSION(`const guint32&',`guint32',`$3')

_CONVERSION(`GQuark',`Glib::QueryQuark',`Glib::QueryQuark($3)')
_CONVERSION(`const Glib::QueryQuark&',`GQuark',`$3')

_CONV_ENUM(Gst,BufferCopyFlags)
_CONV_ENUM(Gst,BufferFlag)
_CONV_ENUM(Gst,ClockEntryType)
_CONV_ENUM(Gst,ClockReturn)
_CONV_ENUM(Gst,EventType)
_CONV_ENUM(Gst,Format)
_CONV_ENUM(Gst,MessageType)
_CONV_ENUM(Gst,PadDirection)
_CONV_ENUM(Gst,PadLinkReturn)
_CONV_ENUM(Gst,PadPresence)
_CONV_ENUM(Gst,QueryType)
_CONV_ENUM(Gst,SeekFlags)
_CONV_ENUM(Gst,SeekType)
_CONV_ENUM(Gst,State)
_CONV_ENUM(Gst,StateChange)
_CONV_ENUM(Gst,StateChangeReturn)
