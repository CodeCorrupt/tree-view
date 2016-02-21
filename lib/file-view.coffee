{CompositeDisposable} = require 'event-kit'
FileIcons = require './file-icons'

module.exports =
class FileView extends HTMLElement
  initialize: (@file, @targetList) ->
    @subscriptions = new CompositeDisposable()
    @subscriptions.add @file.onDidDestroy => @subscriptions.dispose()

    @draggable = true
    @isTargetFile = false
    console.log(@targetList);
    console.log(@file);

    # style the component here
    # if the file exist in the list of .ts generated files,
    # and the files are not of targetExt
    # hide them
    @fileExt = @getFileExt(@file)
    @fileNameWithoutExt = @getFileNameWithoutExt(@file)

    console.log(@fileNameWithoutExt);

    for files in @targetList
        if @fileNameWithoutExt == files
          if !@isTargetFileExt(@fileExt )
            @isTargetFile = true

    if @isTargetFile
      @classList.add('file', 'entry', 'list-item', 'list-virtual-nest', 'list')
    else
      @classList.add('file', 'entry', 'list-item')

    @fileName = document.createElement('span')
    @fileName.classList.add('name', 'icon')
    @appendChild(@fileName)
    @fileName.textContent = @file.name
    @fileName.title = @file.name
    @fileName.dataset.name = @file.name
    @fileName.dataset.path = @file.path

    @fileName.classList.add(FileIcons.getService().iconClassForPath(@file.path))

    @subscriptions.add @file.onDidStatusChange => @updateStatus()
    @updateStatus()

  updateStatus: ->
    @classList.remove('status-ignored', 'status-modified',  'status-added')
    @classList.add("status-#{@file.status}") if @file.status?

  getPath: ->
    @fileName.dataset.path

  isPathEqual: (pathToCompare) ->
    @file.isPathEqual(pathToCompare)

  getFileExt: (file) ->
    @tmpName = file.name.split('.')
    @fileExt = @tmpName[@tmpName.length - 1]

    if @fileExt == 'map'
      @fileExt = @tmpName[@tmpName.length - 2]

    return @fileExt

  getFileNameWithoutExt: (file) ->
    @tmpName = file.name.split('.')
    @tmpNameTwo = '';

    if @tmpName[@tmpName.length - 1] == 'map'

      for tmp in @tmpName
        # if not targetExt and not .map
        if tmp != @tmpName[@tmpName.length - 1] && tmp != @tmpName[@tmpName.length - 2]
          @tmpNameTwo = @tmpNameTwo + tmp + "."

    else
      for tmp in @tmpName
        # if not targetExt and not .map
        if tmp != @tmpName[@tmpName.length - 1]
          @tmpNameTwo = @tmpNameTwo + tmp + "."

    return @tmpNameTwo.slice(0, -1)

  isTargetFileExt: (fileExt) ->
    if fileExt == 'ts'
      return true
    else
      return false

module.exports = document.registerElement('tree-view-file', prototype: FileView.prototype, extends: 'li')
