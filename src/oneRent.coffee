App = React.createClass
  getInitialState: ->
    # headings: ['_id', 'body', 'type', 'replyUrl', 'url', 'title', 'price', 'region', 'location', 'hasPic', 'date', 'id']
    headings: ['date', 'title', 'price', 'location', 'url', 'replyUrl']
    listings: []
    page: 0
    field: '_id'
    order: 1

  getListings: (page, field, order) ->
    tableData =
      page: page
      pageSize: 20
      field: field
      order: order

    $.get 'listings.json', tableData, ((listings) ->
      this.setState
        listings: listings
        page: page
        field: field
        order: order
      return
    ).bind this

  componentDidMount: ->
    this.getListings(this.state.page, this.state.field, this.state.order)

  onPageEvent: (direction) ->
    if direction == 'Next Page'
      newPage = this.state.page + 1
    else if direction == 'Previous Page' and this.state.page > 0
      newPage = this.state.page - 1
    else
      return
    this.getListings(newPage, this.state.field, this.state.order)
    return

  onSortEvent: (selectedField) ->
    if selectedField != this.state.field
      order = this.state.order
      field = selectedField
    else 
      order = this.state.order * -1
      field = this.state.field
    this.getListings(this.state.page, field, order)
    return

  render: ->
    <div className= 'app'>
      <h1>OneRent Listings</h1>
      <div id= 'innerContainer'>
        <ListingsTable listings= {this.state.listings} headings= {this.state.headings} field= {this.state.field} order= {this.state.order} onSortEvent= {this.onSortEvent}/>
        <div id= "map"></div>      
      </div>
      <Arrows onPageEvent= {this.onPageEvent}  page= {this.state.page}/>
    </div>


ListingsTable = React.createClass
  render: ->
    tableHeadings = this.props.headings.map ((heading) ->
      <ListingHeading onSortEvent= {this.props.onSortEvent} field= {this.props.field} order= {this.props.order}>
        {heading}
      </ListingHeading>
    ).bind this

    tableRows = this.props.listings.map ((listing, index) ->
      position = if (index % 2 != 0) then 'odd' else ''

      <ListingRow position= {position} headings= {this.props.headings}>
        {listing}
      </ListingRow>
    ).bind this

    <table id= 'listings' className= "tablesorter">
      <thead>
      <tr>
        {tableHeadings}
      </tr>
      </thead>
      <tbody>
        {tableRows}
      </tbody>
    </table>


ListingHeading = React.createClass
  handleSortRequest: (e) ->
    this.props.onSortEvent(e.target.innerText)

  render: ->
    if this.props.field == this.props.children
      currentClass = if this.props.order > 0 then 'headerSortUp' else 'headerSortDown'
    currentClass += ' header'

    <th className= {currentClass} onClick= {this.handleSortRequest}>
      {this.props.children}
    </th>


ListingRow = React.createClass
  requestLocation: (e)->
    position = this.props.headings.indexOf('location')
    newLocation = e.currentTarget.children[position].innerText.match(/^\w+(\s\w+)*(?= \/)?/)[0]
    initMap(newLocation)

  render: ->
    tableCells = this.props.headings.map ((heading) ->
      if /url/ig.test heading
        text = if heading == 'replyUrl' then 'Reply' else 'Listing'
        return (
          <ListingCell>
            <a href= {this.props.children[heading]}>{text}</a>
          </ListingCell>
        )
      else
        return (
          <ListingCell>
            {this.props.children[heading]}
          </ListingCell>
        )
    ).bind this

    <tr className= {this.props.position} onClick= {this.requestLocation}>
     {tableCells}
    </tr>


ListingCell = React.createClass
  render: ->
    <td>{this.props.children}</td>


Arrows = React.createClass
  handlePageRequest: (e) ->
    this.props.onPageEvent(e.target.value)

  render: ->
    <div className= 'buttons'>
      <p>Page {this.props.page + 1}</p>
      <input type= 'button' value= 'Previous Page' onClick= {this.handlePageRequest} />
      <input type= 'button' value= 'Next Page' onClick= {this.handlePageRequest} />
    </div>


React.render(
  <App/>,
  document.getElementById('Container')
)
