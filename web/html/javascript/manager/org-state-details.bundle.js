(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
'use strict';

var React = require("react");

var Messages = React.createClass({
    displayName: "Messages",

    _classNames: {
        "error": "danger",
        "success": "success",
        "info": "info",
        "warning": "warning"
    },

    getInitialState: function getInitialState() {
        return {};
    },

    render: function render() {
        var msgs = this.props.items.map(function (item) {
            return React.createElement(
                "div",
                { className: 'alert alert-' + this._classNames[item.severity] },
                item.text
            );
        }.bind(this));
        return React.createElement(
            "div",
            null,
            msgs
        );
    }

});

module.exports = {
    Messages: Messages
};

},{"react":"react"}],2:[function(require,module,exports){
'use strict';

var React = require("react");

var PanelButton = React.createClass({
  displayName: "PanelButton",

  getInitialState: function getInitialState() {
    return {};
  },

  render: function render() {
    return React.createElement(
      "div",
      { className: "spacewalk-toolbar" },
      React.createElement(
        "a",
        { href: this.props.action },
        React.createElement("i", { className: 'fa ' + this.props.icon }),
        t(this.props.text)
      )
    );
  }
});

var Panel = React.createClass({
  displayName: "Panel",

  getInitialState: function getInitialState() {
    return {};
  },

  render: function render() {
    return React.createElement(
      "div",
      null,
      React.createElement(
        "div",
        { className: "spacewalk-toolbar-h1" },
        this.props.button,
        React.createElement(
          "h1",
          null,
          React.createElement("i", { className: 'fa ' + this.props.icon }),
          t(this.props.title)
        )
      ),
      this.props.children
    );
  }
});

module.exports = {
  Panel: Panel,
  PanelButton: PanelButton
};

},{"react":"react"}],3:[function(require,module,exports){
'use strict';

var React = require("react");

var Panel = require("../components/panel").Panel;
var Messages = require("../components/messages").Messages;

var Button = React.createClass({
    displayName: "Button",

    render: function render() {
        return React.createElement(
            "button",
            { type: "button", className: 'btn ' + this.props.className, onClick: this.props.handler },
            React.createElement("i", { className: 'fa ' + this.props.icon }),
            this.props.text
        );
    }
});

var StateDetail = React.createClass({
    displayName: "StateDetail",

    _titles: {
        "add": t("Add state"),
        "edit": t("Edit state"),
        "delete": t("Delete state"),
        "info": t("View state")
    },

    getInitialState: function getInitialState() {
        return {};
    },

    handleCreate: function handleCreate(e) {
        this._save(e, "POST");
    },

    handleUpdate: function handleUpdate(e) {
        this._save(e, "PUT");
    },

    handleDelete: function handleDelete(e) {
        var r = confirm(t("Are you sure you want to delete state '{0}' ?", this.props.sls.name));
        if (r == true) {
            this._save(e, "DELETE");
        }
    },

    _save: function _save(e, httpMethod) {
        var formData = {};
        formData['name'] = React.findDOMNode(this.refs.stateName).value.trim();
        formData['content'] = React.findDOMNode(this.refs.stateContent).value.trim();
        if (this.props.sls.checksum) {
            formData['checksum'] = this.props.sls.checksum;
        }

        $.ajax({
            url: window.location.href + (csrfToken ? "?csrf_token=" + csrfToken : ""),
            dataType: 'json',
            contentType: "application/json",
            type: httpMethod,
            data: JSON.stringify(formData),
            success: function (data) {
                console.log(data);
                this.setState({ messages: [data.message] });
                window.location.href = data.url;
            }.bind(this),

            error: function (xhr, status, err) {
                if (xhr.status == 400) {
                    // validation err
                    var errs = $.parseJSON(xhr.responseText);
                    this.setState({ errors: errs });
                } else if (xhr.status == 500) {
                    this.setState({ errors: [t("An internal server error occurred")] });
                } else {
                    console.error(status, err.toString());
                }
            }.bind(this)
        });
    },

    render: function render() {
        var errs = null;
        if (this.state.errors) {
            errs = React.createElement(Messages, { items: this.state.errors.map(function (e) {
                    return { severity: "error", text: e };
                }) });
            //            errs = this.state.errors.map( function(e) {
            //                    return (<div className="alert alert-danger">{t(e)}</div>)
            //                   })
        }

        //        if (this.state.messages) {
        //            errs = this.state.messages.map( function(e) {
        //                    return (<div className="alert alert-info">{t(e)}</div>)
        //                   });
        //        }

        var buttons = [];
        if (this.props.sls.action == "edit") {
            buttons.push(React.createElement(Button, { className: "btn-success", icon: "fa-plus", text: t("Save state"), handler: this.handleUpdate }), React.createElement(Button, { className: "btn-danger", icon: "fa-trash", text: t("Delete state"), handler: this.handleDelete }));
        } else {
            buttons.push(React.createElement(Button, { className: "btn-success", icon: "fa-plus", text: t("Create state"), handler: this.handleCreate }));
        }
        // TODO show readonly if action==delete or info
        return React.createElement(
            Panel,
            { title: this._titles[this.props.sls.action], icon: "spacewalk-icon-virtual-host-manager" },
            errs,
            React.createElement(
                "form",
                { className: "form-horizontal" },
                React.createElement(
                    "div",
                    { className: "form-group" },
                    React.createElement(
                        "label",
                        { className: "col-md-3 control-label" },
                        "Name:"
                    ),
                    React.createElement(
                        "div",
                        { className: "col-md-6" },
                        React.createElement("input", { className: "form-control", type: "text", name: "name", ref: "stateName",
                            defaultValue: this.props.sls.name })
                    )
                ),
                React.createElement(
                    "div",
                    { className: "form-group" },
                    React.createElement(
                        "label",
                        { className: "col-md-3 control-label" },
                        "Content:"
                    ),
                    React.createElement(
                        "div",
                        { className: "col-md-6" },
                        React.createElement("textarea", { className: "form-control", rows: "20", name: "content", ref: "stateContent",
                            defaultValue: this.props.sls.content })
                    )
                ),
                React.createElement(
                    "div",
                    { className: "form-group" },
                    React.createElement(
                        "div",
                        { className: "col-md-offset-3 col-md-6" },
                        buttons
                    )
                )
            )
        );
    }
});

React.render(React.createElement(StateDetail, { sls: stateData() }), document.getElementById('state-details'));

},{"../components/messages":1,"../components/panel":2,"react":"react"}]},{},[3]);
