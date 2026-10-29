let ids = [];
for (let i in imports.ui.status.keyboard.getInputSourceManager().inputSources) {
  ids.push({key: i, value: imports.ui.status.keyboard.getInputSourceManager().inputSources[i].id})
};
ids[2]
