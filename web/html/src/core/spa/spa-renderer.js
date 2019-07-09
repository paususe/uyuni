//@flow
// globals onDocumentReadyInitOldJS
import type {Element as ReactElement} from 'react';
import ReactDOM from 'react-dom';
import React from 'react';

declare var onDocumentReadyInitOldJS: Function;

window.pageRenderers = window.pageRenderers || {};
window.pageRenderers.spa = window.pageRenderers.spa || {};
window.pageRenderers.spa.globalRenderersToUpdate = window.pageRenderers.spa.globalRenderersToUpdate || [];

window.pageRenderers = window.pageRenderers || {};
window.pageRenderers.spa = window.pageRenderers.spa || {};
window.pageRenderers.spa.navigationRenderersToClean = window.pageRenderers.spa.navigationRenderersToClean || [];

function renderGlobalReact(element: ReactElement<any>, container: Element) {

  function registerGlobalRender(instance) {
    window.pageRenderers.spa.globalRenderersToUpdate.push(instance);
  }
  const elementWithRef = React.cloneElement(element, {ref: registerGlobalRender});
  ReactDOM.render(elementWithRef, container);
}

function renderNavigationReact(element: ReactElement<any>, container: Element) {
  window.pageRenderers.spa.navigationRenderersToClean.push({
      element,
      container,
      clean: () => ReactDOM.unmountComponentAtNode(container)
    });
  // TODO: review this onDocumentReadyInitOldJS to run only once
  ReactDOM.render(element, container, () => onDocumentReadyInitOldJS());
}

function onSpaEndNavigation() {
  window.pageRenderers.spa.globalRenderersToUpdate.forEach(
    comp => comp.onSPAEndNavigation && comp.onSPAEndNavigation()
  );

  window.pageRenderers.spa.navigationRenderersToClean.forEach(
    navigationRenderer => {
      try {
        navigationRenderer.clean()
      } catch (error) {
        console.error(error);
      }
    }
  );
  window.pageRenderers.spa.navigationRenderersToClean = [];
}

export default {
  renderGlobalReact,
  renderNavigationReact,
  onSpaEndNavigation
}
