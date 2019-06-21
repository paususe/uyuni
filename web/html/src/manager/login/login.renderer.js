import ReactDOM from 'react-dom';
import React from 'react';
import Login from './login';

window.pageRenderers = window.pageRenderers || {};
window.pageRenderers.login = window.pageRenderers.login || {};
window.pageRenderers.login.renderer = (id, {
  isUyuni,
  urlBounce,
  validationErrors,
  schemaUpgradeRequired,
  webVersion,
  productName,
  customHeader,
  customFooter
}) => {
  ReactDOM.render(
    <Login
      isUyuni={isUyuni}
      bounce={urlBounce}
      validationErrors={validationErrors}
      schemaUpgradeRequired={schemaUpgradeRequired}
      webVersion={webVersion}
      productName={productName}
      customHeader={customHeader}
      customFooter={customFooter}
    />,
    document.getElementById(id),
  );
};
